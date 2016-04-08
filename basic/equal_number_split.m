function [ data_cells ] = equal_number_split( data, nbins )
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	11-Jan-2016
% 
% Aim:
% 			- split data into N bins with equal rows
% Example:
% 			- data = equal_number_split([x, y], 5);
% INPUT:
% 			- data:     data (columns)
% 			- nbins:	number of bins
% OUTPUT:
% 			- data_cells:   data with equal rows in each bin/cell

% remove NaN/Inf
indValid = all(~ isnan(data) | isinf(data), 2);
dataValid = double(data(indValid, :));

% determine the number of elements in each bin
numValid = sum(indValid);
numInEachBin = fix(numValid/nbins);

% assign valid data to each bin (cells)
data_cells = cell(nbins, 1);
for i = 1:nbins
    if i == nbins
        data_cells{i, 1} = dataValid(((i-1)*numInEachBin+1):end, :);
    else
        data_cells{i, 1} = dataValid((1:numInEachBin)+(i-1)*numInEachBin, :);
    end
    
end

