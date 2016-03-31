function [] = ezpadova_get_t_isochrones( s, filepath )
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	24-Mar-2016
% 
% Aim:
% 			- get PADOVA isochrones with a list of AGE using python wrapper
% Example:
% 			- ezpadova_get_t_isochrones('6.6, 6.8, 0.1, 0.02, phot=''sloan'', isoc_kind=''parsec_CAF09_v1.2S_NOV13''', './test3.csv');		-
% INPUT:
% 			- s: string of parameters
% 			- filepath: the path to which isochrone table will be written

if isstruct(s)
    s = struct2str(s);
    ezpadova_get_one_isochrone( s, filepath );
else
    c = sprintf('python %s/isochrone/ezpadova_get_t_isochrones.py "%s" %s', ...
        bomb_dir_install, s, filepath);
    fprintf('@Cham: evaluating command ...\n');
    disp(c);
    system(c);
end



end

