function [fitresult, gof] = createFit_duoxiangshi(xxx, yyy)
%CREATEFIT1(XXX,YYY)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : xxx
%      Y Output: yyy
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 09-Sep-2021 23:36:35 自动生成


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( xxx, yyy );

% Set up fittype and options.
ft = fittype( 'poly3' );

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft );

% Plot fit with data.
h = plot( fitresult, xData, yData );
legend( h, '原始点', '拟合曲线', 'Location', 'NorthEast' );
% Label axes
xlabel 温度
ylabel 乙醇转化率
grid on



