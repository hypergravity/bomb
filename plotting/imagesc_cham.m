function [h, hc] = imagesc_cham(xcenter,ycenter,cdata,alphadata,clim,cmap)
% Written by: 		Chao Liu (NAOC, liuchao@nao.cas.cn)
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	21-Apr-2016
% 
% Aim:
% 			- To overcome the difficulty of 'AlphaData'
% Example:
% 			- h = imagesc_cham(1:10,1:10,magic(10),magic(10)>50,[50 100],gray);
% 			-
% INPUT:
% 			-
% 			-
% OUTPUT:
% 			-
% 			-
% HISTORY:
% 			- 2015.06.05
% 			-


% xstep = xcenter(2)-xcenter(1);
% ystep = ycenter(2)-ycenter(1);

% ##########################################
% color
% ##########################################

cdata(cdata<clim(1))=clim(1);
cdata(cdata>clim(2))=clim(2);
cdata=ceil((cdata-clim(1))./(clim(2)-clim(1))*length(cmap));

xcenter=[xcenter(1)-(xcenter(2)-xcenter(1)),xcenter,xcenter(end)+xcenter(end)-xcenter(end-1)];
ycenter=[ycenter(1)-(ycenter(2)-ycenter(1)),ycenter,ycenter(end)+ycenter(end)-ycenter(end-1)];

x1=(xcenter(2:end)+xcenter(1:end-1))/2;
y1=(ycenter(2:end)+ycenter(1:end-1))/2;

% ##########################################
% draw
% ##########################################
h = hggroup;
hold on;
for i = 1:length(x1)-1
    for j = 1:length(y1)-1
        if alphadata(j,i) > 0
            a = [x1(i),x1(i),x1(i+1),x1(i+1),x1(i)];
            b = [y1(j),y1(j+1),y1(j+1),y1(j),y1(j)];
            if cdata(j,i) <= 0 || isnan(cdata(j,i))
                cdata(j,i)=1;
            end
            f = fill(a,b,cmap(cdata(j,i),:));
            set(f,'LineStyle','none');
            set(f,'HitTest','off','Parent',h);
            
        end
    end
end
colormap(cmap);
% hc = colorbar();
set(gca,'CLim',clim);
% set(h,'Visible','on');
end
% whos h
% get(h,'Children')