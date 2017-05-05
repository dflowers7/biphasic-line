
a = -3;
b = 2;
x0 = 1;
n = 2;
y0 = 2;
aplot = @(x)a.*(x-x0)+y0;
bplot = @(x)b.*(x-x0)+y0;
testplot = @(x)biphasicline(x,a,b,x0,n,y0);
limits = [x0-5 x0+5];
figure; hold on
fplot(testplot,limits)
fplot(aplot,limits)
fplot(bplot,limits)