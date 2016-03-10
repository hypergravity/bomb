function [fitresult, gof] = norm_spec_echelle(...
    w, f, level, npixhf, fmincut, ...
    n_iter, n_sig_u, n_sig_l)


% indgood
indgood = find_mask_1sigma( w, f, level, npixhf, fmincut);

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


end

