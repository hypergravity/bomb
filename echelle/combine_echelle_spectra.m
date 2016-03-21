function [ sp_interp ] = combine_echelle_spectra(orders, ecsp, wave_interp,...
    level, npixhf, fmincut, n_iter, n_sig_u, n_sig_l, trimovlp_uplim, figpath)
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	21-Mar-2016
% 
% Aim:
% 			- combine echelle orders
% Example:
% 			- sp = combine_echelle_spectra(orders, ecsp, wave_interp,...
%               0.5, 20, 50, 5, 3, 1, 20, figpath);
% INPUT:
% 			- orders:           number array 
% 			- ecsp:             cell array of spectra (in table form)
% 			- wave_interp:      interpolated wavelength array
% 			- level:            fraction of pixels left
% 			- npixhf:           number of mask pixels using correlation
% 			- fmincut:          flux min cut
% 			- n_iter:           number of interation in finding continuum
% 			- n_sig_u:          how many sigmas to reserve (upper)
% 			- n_sig_l:          how many sigmas to reserve (lower)
% 			- trimovlp_uplim:   maximum overlap length allowed
% 			- figpath:          figure path (if 0, dont print)
% OUTPUT:
% 			- sp_interp:        combined (interpolated) spectra (six columns)
%               - wave_interp:  interpolated wave 
%               - flux_interp:  interpolated flux
%               - cont_interp:  interpolated combined continuum
%               - flag_interp:  1(only), 2(overlap), 3()
%               - dfmn_interp:  for overlap region, mean diff from the two
%                               overlaped orders
%               - dfmx_interp:  for overlap region, maximum diff from the two
%                               overlaped orders

%% warning off
warning off

%% columnize data
orders = columnize(orders); % columnize orders
ecsp = columnize(ecsp);     % columnize ecsp

sz = size(ecsp);


%% normalize flux
fitresults = cell(sz);
gofs = cell(sz);
ind_bad = false(sz);    % bad orders (which I can not find continuum)

for i = 1:length(ecsp)
    try
        sp = ecsp{i};
        [fitresults{i}, gofs{i}] = norm_spec_echelle(...
            sp.wave, sp.flux, level, npixhf, fmincut, n_iter, n_sig_u, n_sig_l, figpath);
        fprintf('@Cham: normalizing order %d ...\n', orders(i));
    catch
        ind_bad(i) = true;
        fprintf('@Cham: abandoned order %d ...\n', orders(i));
    end
end

% delete bad order data
orders(ind_bad) = [];
ecsp(ind_bad) = [];
fitresults(ind_bad) = [];
gofs(ind_bad) = [];

sz = size(ecsp);


%% wave min max cen
wave_min   = zeros(sz);
wave_max   = zeros(sz);
wave_cen   = zeros(sz);
wave_trim1 = zeros(sz);
wave_trim2 = zeros(sz);

for j = 1:length(orders)
%     order = orders(j);
    sp = ecsp{j};
    
    wave_min(j) = min(sp.wave);
    wave_max(j) = max(sp.wave);
    wave_cen(j) = (wave_min(j) + wave_max(j)) / 2;
    
    [ wave_trim1(j), wave_trim2(j) ] = ...
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
            t.wave_only2(i) = t.wave_max(i);
        else
            % not overlap previous
            t.wave_only1(i) = t.wave_min(i);
            t.wave_only2(i) = t.wave_max(i);
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
if ~ iscolumn(wave_interp)
    wave_interp = wave_interp';
end
flux_interp = nan(size(wave_interp));
cont_interp = nan(size(wave_interp));
flag_interp = nan(size(wave_interp));
dfmn_interp = zeros(size(wave_interp));
dfmx_interp = zeros(size(wave_interp));

% interpolate ovlp region
for i = 1:height(t)-1
    if t.trimovlp_len(i) > 0
        % overlap
        odb = find(orders == t.orders(i));
        odr = find(orders == t.orders(i+1));
        
        spb = ecsp{odb};
        spr = ecsp{odr};
        
        fitresultb = fitresults{odb};
        fitresultr = fitresults{odr};
        
        ind_ = wave_interp>t.wave_ovlp1(i) & wave_interp<t.wave_ovlp2(i);
        wave_ind = wave_interp(ind_);
        
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
        flag_interp(ind_) = 2;
        dfmn_interp(ind_) = mean([abs(flux_ind-flux_normb), abs(flux_ind-flux_normr)], 2);
        dfmx_interp(ind_) = max([abs(flux_ind-flux_normb) abs(flux_ind-flux_normr)], [], 2);
        %fprintf('@Cham: interpolating normalized flux between orders [%d, %d] ...\n', i, i+1)
    else
        % not overlap, so: flag = -1; 
        ind_ = wave_interp>t.wave_only2(i) & wave_interp<t.wave_only1(i+1);
        flag_interp(ind_) = -1;
    end
end

% interpolate only region
for i = 1:height(t)
    od = find(orders == t.orders(i));
    sp = ecsp{od};

    fitresult = fitresults{od};
    
    ind_ = wave_interp>t.wave_only1(i) & wave_interp<t.wave_only2(i);
    wave_ind = wave_interp(ind_);

    cont = fitresult(wave_ind);
    flux = interp1(sp.wave, sp.flux, wave_ind, 'pchip');
    flux_norm = flux ./ cont;

    flux_interp(ind_) = flux_norm';
    cont_interp(ind_) = cont;
    flag_interp(ind_) = 1;
end


%% construct combined spectra (table form)
sp_interp = table(...
    wave_interp, flux_interp, ...
    cont_interp, flag_interp, ...
    dfmn_interp, dfmx_interp);

fprintf('@Cham: mission complete ...\n');


end


