function [ data_rowized ] = rowize( data )
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	21-Mar-2016
% 
% Aim:
% 			- rowize data if possible
% Example:
% 			- a = [1 2 3]';
% 			- a = rowize(a);
% INPUT:
% 			- data: data
% OUTPUT:
% 			- data_rowized: rowized data

if isvector(data)
    % data is a vector
    if ~ isrow(data)
        % if data is a row, rowize orders
        data_rowized = data';
    else
        data_rowized = data;
    end
else
    % data can not be rowized
    error('@Cham: data can not be rowized!');
end

end

