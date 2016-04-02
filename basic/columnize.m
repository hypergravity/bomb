function [ data_columnized ] = columnize( data )
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	21-Mar-2016
% 
% Aim:
% 			- columnize data if possible
% Example:
% 			- a = [1 2 3];
% 			- a = columnize(a);
% INPUT:
% 			- data: data
% OUTPUT:
% 			- data_columnized: columnized data

if isvector(data)
    % data is a vector
    if ~ iscolumn(data)
        % if data is a row, columnize orders
        data_columnized = data';
    else
        data_columnized = data;
    end
else
    % data can not be columnized
    error('@Cham: data can not be columnized!');
end

end

