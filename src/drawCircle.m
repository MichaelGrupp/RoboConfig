%call plot(XVals, YVals) from outside
function [XVals, YVals] = drawCircle(circle)

res = 0.05; %angular resolution
ang=0:res:2*pi+res; %angular steps

x = circle(1);
y = circle(2);
r = circle(3);

xp = r*cos(ang);
yp = r*sin(ang);

XVals = x+xp;
YVals = y+yp;

end