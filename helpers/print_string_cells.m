function [  ] = print_string_cells( string_cells )
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	14-Apr-2016
% 
% Aim:
% 			- to print multi-line string
% Example:
% 			-
% 			-
% INPUT:
% 			- string_cells: cells of strings
% 			-
% OUTPUT:
% 			-
% 			-
% HISTORY:
% 			-
% 			-

for i = 1:length(string_cells)
    fprintf('%s\n', string_cells{i});
end

end

