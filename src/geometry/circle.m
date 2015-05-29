function [circle] = circle(link)

calcLength = @(XData, YData) sqrt((XData(2)-XData(1))^2 + (YData(2)-YData(1))^2);

%link parameters
XData = get(link, 'XData'); %[x1, x2]
YData = get(link, 'YData'); %[y1, y2]

%radius is same as linkLength, center xc,yc at joint
r = calcLength(XData, YData);
xc = XData(1);
yc = YData(1);

circle = [xc, yc, r];

end