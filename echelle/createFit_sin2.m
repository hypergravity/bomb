function [fitresult, gof] = createFit_sin2(w_, f_)
%CREATEFIT(W_,F_)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : w_
%      Y Output: f_
%      Weights : f_
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 09-Mar-2016 17:44:32


%% Fit: 'untitled fit 1'.
[xData, yData, weights] = prepareCurveData( w_, f_, f_ );

% Set up fittype and options.
ft = fittype( 'sin2' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf 0 -Inf -Inf 0 -Inf];
opts.StartPoint = [24346.7970248337 0.0189428620782721 -2.85329792715458 6227.54391106141 0.0378857241565442 1.57362672098171];
opts.Weights = weights;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'f_ vs. w_ with f_', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel( 'w_' );
ylabel( 'f_' );
grid on

