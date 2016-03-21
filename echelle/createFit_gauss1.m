function [fitresult, gof] = createFit_gauss1(w, cont)
%CREATEFIT(W,CONT)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : w
%      Y Output: cont
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 09-Mar-2016 18:56:09


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( w, cont );

% Set up fittype and options.
ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
% opts.StartPoint = [66288.5874023438 8563.59390208878 36.330183494561];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% plot( xData,fitresult(xData).^4/fitresult.a1, 'r')
% % plot( xData, yData, 'b');
% % legend( h, 'cont vs. w', 'untitled fit 1', 'Location', 'NorthEast' );
% % Label axes
% xlabel( 'w' );
% ylabel( 'cont' );
% grid on


