% Set the line parameters
a = 3; % Slope of left-hand line
b = -2; % Slope of right-hand line
x0 = 1; % x point of line intersection
n = 2;  % Degree of rapidity of change between left and right hand lines. Higher means a more rapid change that looks less smooth
y0 = 2; % y point of line intersection

% Line functions and biphasic functions only as a function of x
aline = @(x)a.*(x-x0)+y0;
bline = @(x)b.*(x-x0)+y0;
testplot = @(x)biphasicline(x,a,b,x0,y0,n);

% Set limits to plot between
limits = [x0-5 x0+5];

% Plot the function compared to the lines
figure; hold on
fplot(testplot,limits)
fplot(aline,limits)
fplot(bline,limits)
xlms = get(gca, 'XLim');
ylms = get(gca, 'YLim');
line([x0 x0], ylms, 'Color', [1 0 0], 'LineStyle', ':')
line(xlms, [y0 y0], 'Color', [0 0.5 0], 'LineStyle', ':')
legend('Biphasic', 'Line a', 'Line b', 'X0', 'Y0', 'Location', 'Best')
hold off

% Test the derivatives via comparison to complex step finite differences
xq = linspace(limits(1), limits(2), 100);
[~,dval] = testplot(xq);
dval_test = testplot(xq + 1e-8i);
dval_test = imag(dval_test)*1e8;
maxerr = max(abs(dval-dval_test));
fprintf('Maximum derivative error is %g\n', maxerr)
