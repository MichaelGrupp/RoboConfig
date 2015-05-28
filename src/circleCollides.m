%check if circle intersects with a line
%algorithm: http://mathworld.wolfram.com/Circle-LineIntersection.html
function [result] = circleCollides(XDataLine, YDataLine, circle)

x = circle(1); y = circle(2); r = circle(3);

dx = XDataLine(2)-XDataLine(1);
dy = YDataLine(2)-YDataLine(1);
dr = (dx^2 + dy^2); %no sqrt here because we need square later anyway

D = XDataLine(1)*YDataLine(2) - XDataLine(2)*YDataLine(1);

%discriminant - we are only interested if there is a intersection
if(((r^2)*dr - D^2) > 0)
    result = 1;
else
    result = 0;
end

end