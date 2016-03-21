function [fitresult, gof] = norm_spec_echelle(...
    w, f, level, npixhf, fmincut, ...
    n_iter, n_sig_u, n_sig_l, figpath)


%% indgood
indgood = find_mask_1sigma( w, f, level, npixhf, fmincut);

%% normalization poly4
if sum(indgood)>8

    for i = 1:n_iter
        % ITERATE 1 -----------
        %fprintf('@Cham: ITERATION - %d \n', i);
        
        % poly4 fit %curvefit_poly4/createFit_sin2/createFit_sin4
        [fitresult, gof] = createFit_poly4(w(indgood),f(indgood));
        
        % res in 1sigma
        res = f-fitresult(w);
        res_std = std(res(indgood));
        ind1sigma = res < n_sig_u*res_std & -res < n_sig_l*res_std;
        
        % combine ind
        indgood = indgood & ind1sigma;

        if sum(indgood)<8
            break
        end
        
    end
else
    error('@Cham: I can''t find good pixels to do normalization!\n');
end

%% diagnostics
if figpath == 0
    return
else
    % print diagnostic figures
    xlim = [min(w) max(w)];
    
    figure('name', figpath, 'visible', 'off');
    
    subplot(221); hold on; box on;
    plot(w, f, 'b')
    plot(w(indgood), f(indgood), 'g')
    plot(w, fitresult(w), 'r')
    l = legend('flux', 'indgood pix', 'continuum fit using poly4');
    set(l, 'location','south','box','off')
    set(gca, 'xlim', xlim)
    xlabel('wavelength')
    ylabel('raw flux')
    
    subplot(222); hold on; box on;
    % plot(w, f, 'b')
    res = f-fitresult(w);
    plot(w(indgood), res(indgood), 'r')
    set(gca, 'xlim', xlim)
    xlabel('wavelength')
    ylabel('indgood pixel flux residuals')
    
    subplot(223); hold on; box on;
    plot(w, f./fitresult(w))
	set(gca, 'xlim', xlim)
    ylabel('normalized flux')
    xlabel('wavelength')
    
    subplot(224); hold on; box on;
    hist(res(indgood))
    xlabel('hist of indgood pixel flux residuals')
    ylabel('count')
    
    set(gcf, 'papersize',[8 6], 'paperposition', [0 0 8 6]);
    print(gcf, '-dpsc', '-append', figpath)
end


end

