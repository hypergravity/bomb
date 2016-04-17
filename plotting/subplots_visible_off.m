function [ fig, axs ] = subplots_visible_off( nrow,ncol,left,bottom,width,height )
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	29-Mar-2016
% 
% Aim:
% 			- subplots with 0 spaces (visible off)
% Example:
% 			- [ fig, axs ] = subplots( 20,20 );
% 			- 
% INPUT:
% 			- nrow, ncol: number of rows & columns
% 			- left, bottom: left and bottom space
%           - width, height: area for subplots (0 to 1)
% OUTPUT:
% 			- fig: handle of figure
% 			- axs: handles of subplots (row x col)

switch nargin
    case 6
        
    case 2
        left = 0.1300;
        bottom = 0.1100;
        width = 0.7750;
        height = 0.8150;
    otherwise
        error('@Cham: Error in input args!')
end

eachWidth = width/ncol;
eachHeight = height/nrow;

fig = figure('Visible','Off');
axs = zeros(nrow,ncol);
for i = 1:nrow
    for j = 1:ncol
        subplotPosition = [...
            left+(j-1)*eachWidth, bottom+(nrow-i)*eachHeight,...
            eachWidth, eachHeight];
        axs(i,j) = subplot('Position', subplotPosition);
%         set(axs(i,j),'XTickLabel',{''},'YTickLabel',{''})
        hold on; box on;
    end
end

end



