function [ COUNT ] = Bin2D_lc(XData,YData,XVector,YVector)
% Written by: 		Chao Liu
% Modified by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	18-Apr-2016
% 
% Aim:
% 			-
% Example:
% 			-
% 			-
% INPUT:
% 			-XData YData:  to be counted
% 			-XVector,YVector: bin center vector
% OUTPUT:
% 			-
% 			-
% HISTORY:
% 			-
% 			-

% rmin,rmax:    row range of binning matrix
% cmin,cmax:    column range of binning matrix
% rstep,cstep:  row/column bin width
% length:       data size

rmin = XVector(1);rstep = XVector(2)-XVector(1);rmax = XVector(end);
cmin = YVector(1);cstep = YVector(2)-YVector(1);cmax = YVector(end);

len=length(XData);
dr=rmax-rmin;
dc=cmax-cmin;
nr=round(dr/rstep)+1;
nc=round(dc/cstep)+1;

COUNT=zeros(nc,nr);
for i=1:len
    ir=round((XData(i)-rmin)/rstep)+1;
    ic=round((YData(i)-cmin)/cstep)+1;
    if ir>=1 && ir<=nr && ic>=1 && ic<=nc
        COUNT(ic,ir) = COUNT(ic,ir)+1;
    end
end

end
