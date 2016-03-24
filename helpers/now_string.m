function s = now_string(sep)
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	21-Mar-2016
% 
% Aim:
% 			- generate string of current moment
% Example:
% 			- s = now_string();
% 			- now_string
% INPUT:
% 			- sep:  the speration character (default is '-')
% OUTPUT:
% 			- s:    string of current moment

if nargin==0
    s = datestr(now,'yyyy-mm-dd-HH-MM-SS');
else
    s = datestr(now,'yyyy-mm-dd-HH-MM-SS');
    s = strrep(s,'-',sep);
end