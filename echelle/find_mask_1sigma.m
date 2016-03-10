function [ indgood ] = find_mask_1sigma( w, f, level, npixhf, fmincut)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% indgood = true(size(f));

f_diff = diff(f);

f_diff_r = [f_diff; nan] ./ f;
% f_diff_l = [nan; f_diff] ./ f;

u = zeros(size(f_diff_r));
u(abs(f_diff_r)>level) = 1.;

v = ones(2*npixhf + 1, 1);

w = conv(u, v);

indgood = ~ logical(w(npixhf+1:end-npixhf)) & f>fmincut;


end

