function [ fig, axs ] = subplots_tight( nrow,ncol,left,bottom,width,height,hspace,vspace)
% Written by: 		Bo Zhang (NAOC, bozhang@nao.cas.cn)
% Last modified: 	29-Mar-2016
% 
% Aim:
% 			- subplots with space adjusted
% Example:
% 			- [ fig, axs ] = subplots( 20,20 );
% 			- [ fig, axs ] = subplots_tight( 3,2,0.05,0.05,0.9,0.96,0.02,0.02);
% INPUT:
% 			- nrow, ncol: number of rows & columns
% 			- left, bottom: left and bottom space
%           - width, height: area for subplots (0 to 1)
% OUTPUT:
% 			- fig: handle of figure
% 			- axs: handles of subplots (row x col)

switch nargin
    case 8
        
    case 6
        hspace = 0.02;
        vspace = 0.02;
    case 2
        left = 0.1300;
        bottom = 0.1100;
        width = 0.7750;
        height = 0.8150;
        hspace = 0.02;
        vspace = 0.02;
    otherwise
        error('@Cham: Error in input args!')
end

eachWidth = width/ncol;
eachHeight = height/nrow;

fig = figure();
axs = zeros(nrow,ncol);
for i = 1:nrow
    for j = 1:ncol
        subplotPosition = [...
            left+(j-1)*eachWidth, bottom+(nrow-i)*eachHeight, ...
            eachWidth-hspace, eachHeight-vspace];
        axs(i,j) = subplot('Position', subplotPosition);
%         set(axs(i,j),'XTickLabel',{''},'YTickLabel',{''})
        hold on; box on;
    end
end

end

