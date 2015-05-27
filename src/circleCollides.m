%check if circle intersects with a line via projection
function [result] = circleCollides(XDataLine, YDataLine, circle)

x = circle(1); y = circle(2); r = circle(3);

%connections from line start/end to center of circle
c1 = [x-XDataLine(1)-x; x-YDataLine(1)];
c2 = [x-XDataLine(2); y-YDataLine(2)];

line = [XDataLine(1)-XDataLine(2); YDataLine(1)-YDataLine(2)];

a = dot(c2, line/norm(line));
p = a*(line/norm(line));
p = [XDataLine(2); YDataLine(2)] - [x-p(1); y-p(2)];

if(norm(p) < r && (norm(c1) < r || norm(c2) < r))
    result = 1;
else
    result = 0;
end

end