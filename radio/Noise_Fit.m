function [fitresult, gof] = Noise_Fit(band_f_log, band_fa)
  %% Fit: 'Band'.
  [xData, yData] = prepareCurveData( band_f_log, band_fa );

				% Set up fittype and options.
  ft = fittype( 'fourier6' );
  opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
  opts.Display = 'Off';
  opts.StartPoint = [0 0 0 0 0 0 0 0 0 0 0 0 0 0.785398163397448];

				% Fit model to data.
  [fitresult, gof] = fit( xData, yData, ft, opts );

				% Plot fit with data.
				% figure( 'Name', 'Band' );
				% h = plot( fitresult, xData, yData );
% legend( h, 'band_fa vs. band_f_log', 'Band', 'Location', 'NorthEast' );
% % Label axes
% xlabel band_f_log
% ylabel band_fa
% grid on


