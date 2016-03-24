function str = struct2str( s, sep_int, sep_btw )
% Written by: 		Bo Zhang(NAOC, bozhang@nao.cas.cn)
% Last modified: 	24-Mar-2016
% 
% Aim:
% 			- turn a struct into a string
% Example:
% 			- str = struct2str(s, '=', ', ');
% INPUT:
% 			- s: struct
% 			- sep_int: sep between field name and value
% 			- sep_btw: sep between different fields
% OUTPUT:
% 			- str: string

% field names --> cells
fldnames = fieldnames(s);

% initialize string
str = sprintf('%s%s%s', ...
    fldnames{1}, sep_int, struct_value_to_string(s.(fldnames{1})));

% cat next fields
for i = 2:length(fldnames)
    str_ = sprintf('%s%s%s', ...
        fldnames{i}, sep_int, struct_value_to_string(s.(fldnames{i})));
    str = strcat(str, sep_btw, str_);
end

end


function s = struct_value_to_string(v)
    if isnumeric(v)
        if isinteger(v)
            s = sprintf('%d', v);
        elseif isfloat(v)
            s = sprintf('%.5f', v);
        end
    elseif ischar(v)
        s = v;
    else
        error('@Cham: struct contains invalid value types!\n');
    end
end
    

