function [ ind, w_, f_ ] = find_1sigma_pixels_n( w, f, level, n )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

ind = true(size(f));
ind_ = true(size(f));

for i = 1:n
    ind_ = find_1sigma_pixels(f, (ind & ind_), level);
end

ind = ind & ind_;
w_ = w;
f_ = f;


end

