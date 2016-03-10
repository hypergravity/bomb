function [ ind ] = find_1sigma_pixels( f, ind, level )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%%
if ~ iscolumn(f)
    f = f';
end

f_diff = diff(f);

% kick 3 sigma outlier
% ind_3sigma = abs(f_diff)< std(f_diff);

% f_diff_std = std(f_diff);

f_diff_r = [f_diff; nan] ./ f;
f_diff_l = [nan; f_diff] ./ f;

ind = (f_diff_l.^2 + f_diff_r.^2)<level.^2 ...
    & f>0 ...
    & ind;
ind = logical(ind);


end

