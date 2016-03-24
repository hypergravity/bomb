function [ str_tmpdir ] = bomb_dir_tmp( )
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	24-Mar-2016
% 
% Aim:
% 			- return tmp directory for BOMB package
% Example:
% 			-
% 			-
% INPUT:
% 			-
% 			-
% OUTPUT:
% 			- str_tmpdir: string of the tmp directory


str_tmpdir = sprintf('%s%s%s', bombdir, filesep, 'tmp');

end

