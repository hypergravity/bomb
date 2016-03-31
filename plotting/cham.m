function [] = cham(num)
% Written by: 		Bo Zhang(NAOC, bozhang@nao.cas.cn)
% Last modified: 	18-Jun-2015
%
% aim:              change default setting parameters
% example:
%                   cham    -set to Jing Li style
%                   cham(0) -set to the default
%                   cham(1) -set to Jing Li style

%% get default settings
% get(0,'Default')
% 
% ans = 
% 
%           defaultFigurePosition: [680 558 560 420]
%                defaultTextColor: [0 0 0]
%               defaultAxesXColor: [0 0 0]
%               defaultAxesYColor: [0 0 0]
%               defaultAxesZColor: [0 0 0]
%           defaultPatchFaceColor: [0 0 0]
%           defaultPatchEdgeColor: [0 0 0]
%                defaultLineColor: [0 0 0]
%     defaultFigureInvertHardcopy: 'on'
%              defaultFigureColor: [0.8000 0.8000 0.8000]
%                defaultAxesColor: [1 1 1]
%           defaultAxesColorOrder: [7x3 double]
%           defaultFigureColormap: [64x3 double]
%         defaultSurfaceEdgeColor: [0 0 0]

%% set
switch nargin
    case 0
        % this setting is from Jing Li
        set(0,'DefaultAxesXMinorTick','on');    % x minor tick
        set(0,'DefaultAxesYMinorTick','on');    % y minor tick 
        set(0,'DefaultAxesFontSize',15);        % axes font size 
        set(0,'DefaultAxesLineWidth',1.0);      % axes line width 
        set(0,'DefaultTextFontSize',15);        % text font size 
        set(0,'DefaultLineLineWidth',1.1);      % line width 
        set(0,'DefaultAxesTickLength',[0.015; 0.015]);  % axes tick length
    case 1
        if num == 0 
            % set to the default
            set(0,'DefaultAxesXMinorTick','off');    % x minor tick 
            set(0,'DefaultAxesYMinorTick','off');    % y minor tick 
            set(0,'DefaultAxesFontSize',10);        % axes font size 
            set(0,'DefaultAxesLineWidth',0.5);      % axes line width 
            set(0,'DefaultTextFontSize',10);        % text font size 
            set(0,'DefaultLineLineWidth',0.5);      % line width 
            set(0,'DefaultAxesTickLength',[0.0100    0.0250]);  % axes tick length
        elseif num == 1
            % this setting is from Jing Li
            set(0,'DefaultAxesXMinorTick','on');    % x minor tick
            set(0,'DefaultAxesYMinorTick','on');    % y minor tick 
            set(0,'DefaultAxesFontSize',15);        % axes font size 
            set(0,'DefaultAxesLineWidth',1.0);      % axes line width 
            set(0,'DefaultTextFontSize',15);        % text font size 
            set(0,'DefaultLineLineWidth',1.1);      % line width 
            set(0,'DefaultAxesTickLength',[0.015; 0.015]);  % axes tick length
        end
    otherwise
        error('@Cham: varargin error...');
end
