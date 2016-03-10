function [ sp_interp ] = combine_echelle_spectra(orders, ecsp, wave_interp,...
    level, npixhf, fmincut, n_iter, n_sig_u, n_sig_l, trimovlp_uplim)
% 0.5, 20, 50, 5, 3, 1, 20

warning off

%% reshape data
if ~ iscolumn(orders)
    orders = orders';
end
if ~ iscolumn(ecsp)
    ecsp = ecsp';
end
sz = size(ecsp);

%% normalize flux

fitresults = cell(sz);
gofs = cell(sz);
for i = 1:length(ecsp)
    sp = ecsp{i};
    [fitresults{i}, gofs{i}] = norm_spec_echelle(...
        sp.wave, sp.flux, level, npixhf, fmincut, n_iter, n_sig_u, n_sig_l);
    fprintf('@Cham: normalizing order %d ...\n', orders(i));
end


%% wave min max cen
wave_min   = zeros(sz);
wave_max   = zeros(sz);
wave_cen   = zeros(sz);
wave_trim1 = zeros(sz);
wave_trim2 = zeros(sz);

for order = orders'
    
    sp = ecsp{order};
    
    wave_min(order) = min(sp.wave);
    wave_max(order) = max(sp.wave);
    wave_cen(order) = (wave_min(order) + wave_max(order)) / 2;
    
    [ wave_trim1(order), wave_trim2(order) ] = ...
        find_trim_wave( sp.wave, sp.flux, 5, 100 );
end

t = table(orders, wave_min, wave_max, wave_cen, wave_trim1, wave_trim2);
t = sortrows(t,'wave_cen','ascend');


%% is overlap?
% wave_ovlp_cut = 5;

t.ovlp_len = [t.wave_max(1:end-1) - t.wave_min(2:end); nan];
t.ovlp_len2 = [t.wave_max(1:end-2) - t.wave_min(3:end); nan; nan];

t.trimovlp_len = [t.wave_trim2(1:end-1) - t.wave_trim1(2:end); nan];
t.trimovlp_len2 = [t.wave_trim2(1:end-2) - t.wave_trim1(3:end); nan; nan];

% garantee that: ----------------------------------------------------------
% 1. for those trim is not necessary, don't trim
% 2. for those tirm is appropriate, trim
% 3. for those trim is not enough, trim more

for i = 1:height(t)-1
    if t.ovlp_len(i) < 0
        % tirm is not necessary
        t.wave_trim2(i) = t.wave_max(i);
        t.wave_trim1(i+1) = t.wave_min(i+1);
    
    elseif t.trimovlp_len(i) < 0
        % trim too much
        len_too_much =  (-t.trimovlp_len(i) + 1)/2;
        t.wave_trim2(i) = t.wave_trim2(i) + len_too_much;
        t.wave_trim1(i+1) = t.wave_trim1(i+1) - len_too_much;
    
    elseif t.trimovlp_len2(i) > 0 
        % trim too little
        len_too_little = (t.trimovlp_len2(i) + 1)/2;
        t.wave_trim2(i) = t.wave_trim2(i) - len_too_little;
        t.wave_trim1(i+1) = t.wave_trim1(i+1) + len_too_little;
    end
end

% t.ovlp_len = [t.wave_max(1:end-1) - t.wave_min(2:end); nan];
% t.ovlp_len2 = [t.wave_max(1:end-2) - t.wave_min(3:end); nan; nan];

t.trimovlp_len = [t.wave_trim2(1:end-1) - t.wave_trim1(2:end); nan];
t.trimovlp_len2 = [t.wave_trim2(1:end-2) - t.wave_trim1(3:end); nan; nan];


% garentee that: ----------------------------------------------------------
% trimovlp < 20

for i = 1:height(t)-1
    if t.trimovlp_len(i) > trimovlp_uplim
        % trim still too little
        len_too_little = (t.trimovlp_len(i) - trimovlp_uplim)/2 ;
        t.wave_trim2(i) = t.wave_trim2(i) - len_too_little;
        t.wave_trim1(i+1) = t.wave_trim1(i+1) + len_too_little;
    end 
end

% t.ovlp_len = [t.wave_max(1:end-1) - t.wave_min(2:end); nan];
% t.ovlp_len2 = [t.wave_max(1:end-2) - t.wave_min(3:end); nan; nan];

t.trimovlp_len = [t.wave_trim2(1:end-1) - t.wave_trim1(2:end); nan];
t.trimovlp_len2 = [t.wave_trim2(1:end-2) - t.wave_trim1(3:end); nan; nan];


%% wave only
t.wave_only1 = nan(sz);
t.wave_only2 = nan(sz);
t.wave_ovlp1 = nan(sz);
t.wave_ovlp2 = nan(sz);

% #########################################################################
i = 1;
if t.trimovlp_len(i) > 0
    % overlap next
    t.wave_ovlp1(i) = t.wave_trim1(i+1);
    t.wave_ovlp2(i) = t.wave_trim2(i);

    % not overlap previous
    t.wave_only1(i) = t.wave_trim1(i);
    t.wave_only2(i) = t.wave_trim1(i+1);
else
    % not overlap previous
    t.wave_only1(i) = t.wave_trim1(i);
    t.wave_only2(i) = t.wave_trim2(i);
end

% #########################################################################
for i = 2:height(t)-1
    if t.trimovlp_len(i) > 0
        % overlap next
        
        t.wave_ovlp1(i) = t.wave_trim1(i+1);
        t.wave_ovlp2(i) = t.wave_trim2(i);
        
        if t.trimovlp_len(i-1) > 0
            % overlap previous
            t.wave_only1(i) = t.wave_trim2(i-1);
            t.wave_only2(i) = t.wave_trim1(i+1);
        else
            % not overlap previous
            t.wave_only1(i) = t.wave_trim1(i);
            t.wave_only2(i) = t.wave_trim1(i+1);
        end
        
    else
        % not overlap next
        
        if t.trimovlp_len(i-1) > 0
            % overlap previous
            t.wave_only1(i) = t.wave_trim2(i-1);
            t.wave_only2(i) = t.wave_trim1(i+1);
        else
            % not overlap previous
            t.wave_only1(i) = t.wave_trim1(i);
            t.wave_only2(i) = t.wave_trim1(i+1);
        end
    end
    
end

% #########################################################################
i = height(t);
if t.trimovlp_len(i-1) > 0
    % overlap previous
    t.wave_only1(i) = t.wave_trim2(i-1);
    t.wave_only2(i) = t.wave_trim2(i);
else
    % not overlap previous
    t.wave_only1(i) = t.wave_trim1(i);
    t.wave_only2(i) = t.wave_trim2(i);
end


%% interpolation
fprintf('@Cham: interpolating spectra ...\n');

% wave_interp = 3780:0.01:10812;
flux_interp = nan(size(wave_interp));
cont_interp = nan(size(wave_interp));
flag_interp = nan(size(wave_interp));
dfmn_interp = zeros(size(wave_interp));
dfmx_interp = zeros(size(wave_interp));

% interpolate ovlp region
for i = 1:height(t)-1
    if t.trimovlp_len(i) > 0
        % overlap
        odb = t.orders(i);
        odr = t.orders(i+1);
        
        spb = ecsp{odb};
        spr = ecsp{odr};
        
        fitresultb = fitresults{odb};
        fitresultr = fitresults{odr};
        
        ind_ = wave_interp>t.wave_ovlp1(i) & wave_interp<t.wave_ovlp2(i);
        wave_ind = wave_interp(ind_)';
        
        contb = fitresultb(wave_ind);
        contr = fitresultr(wave_ind);
        fluxb = interp1(spb.wave, spb.flux, wave_ind, 'pchip');
        fluxr = interp1(spr.wave, spr.flux, wave_ind, 'pchip');
        flux_normb = fluxb ./ contb;
        flux_normr = fluxr ./ contr;
        
        weib = linspace(1, 0, length(wave_ind))';
        weir = 1 - weib;
        
        flux_ind = flux_normb .* weib + flux_normr .* weir;
        flux_interp(ind_) = flux_ind';
        cont_interp(ind_) = contb .* weib + contr .* weir;
        flag_interp(ind_) = 1;
        dfmn_interp(ind_) = mean([abs(flux_ind-flux_normb), abs(flux_ind-flux_normr)], 2);
        dfmx_interp(ind_) = max([abs(flux_ind-flux_normb) abs(flux_ind-flux_normr)], [], 2);
        %fprintf('@Cham: interpolating normalized flux between orders [%d, %d] ...\n', i, i+1)
    end
end

% interpolate only region
for i = 1:height(t)
    od = t.orders(i);

    sp = ecsp{od};

    fitresult = fitresults{od};
    
    ind_ = wave_interp>t.wave_only1(i) & wave_interp<t.wave_only2(i);
    wave_ind = wave_interp(ind_)';

    cont = fitresult(wave_ind);
    flux = interp1(sp.wave, sp.flux, wave_ind, 'pchip');
    flux_norm = flux ./ cont;

    flux_interp(ind_) = flux_norm';
    cont_interp(ind_) = cont;
    flag_interp(ind_) = 2;
end

%% construct table

sp_interp = table(...
    wave_interp, flux_interp, ...
    cont_interp, flag_interp, ...
    dfmn_interp, dfmx_interp);

fprintf('@Cham: mission complete ...\n');


