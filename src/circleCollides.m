%check if circle intersects with a line via projection
%like described here: http://doswa.com/2009/07/13/circle-segment-intersectioncollision.html
%plus additional checks implemented
function [result] = circleCollides(XDataLine, YDataLine, circle)

seg_a = [XDataLine(1); YDataLine(1)]; seg_b = [XDataLine(2); YDataLine(2)];
x = circle(1); y = circle(2); r = circle(3);

seg_v = seg_b - seg_a;
pt_v = [x;y] - seg_a;
pt_v2 = [x;y] - seg_b;

proj_v = dot(pt_v, seg_v/norm(seg_v)); %projection norm
proj_v = proj_v * (seg_v/norm(seg_v)); %projection vector

closest = seg_a + proj_v;
dist_v = [x;y] - closest;

if(norm(dist_v) < r && (norm(pt_v) < r || norm(pt_v2) < r)) 
    result = 1;
else
    result = 0;
end

end