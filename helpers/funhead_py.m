function [] = funhead_py()
% Written by: 		Bo Zhang(NAOC, bozhang@nao.cas.cn)
% Last modified: 	11-Jan-2016
% 
% Aim:
% 			- automatically generate module header string
% Example:
% 			- funhead_py()
% OUTPUT:
% 			- string

fprintf([...
    '# -*- coding: utf-8 -*-\n'...
    '"""\n'...
    '\n'...
    'Author\n'...
    '------\n'...
    'Bo Zhang\n'...
    '\n'...
    'Email\n'...
    '-----\n'...
    'bozhang@nao.cas.cn\n'...
    '\n'...
    'Created on\n'...
    '----------\n'...
    '- Fri Jul  3 13:13:06 2015    read_spectrum\n'...
    '\n'...
    'Modifications\n'...
    '-------------\n'...
    '- Wed Jul 29 21:46:00 2015    measure_line_index\n'...
    '- Fri Nov 20 10:16:59 2015    reformatting code\n'...
    '\n'...
    'Aims\n'...
    '----\n'...
    '- to read LAMOST/SDSS spectra\n'...
    '- measure line index from spectra\n'...
    '\n'...
    '"""\n']);


end
