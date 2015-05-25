function [circle] = circle(link)

calcLength = @(XData, YData) sqrt((XData(2)-XData(1))^2 + (YData(2)-YData(1))^2);


ang=0:0.1:2*pi+0.1; %angular resolution, don't need much?
%link parameters
XData = get(link, 'XData'); %[x1, x2]
YData = get(link, 'YData'); %[y1, y2]

%radius is same as linkLength
r = calcLength(XData, YData);
xp = r*cos(ang);
yp = r*sin(ang);
xc = XData(1)+xp;
yc = YData(1)+yp;
circle = [xc; yc];

end