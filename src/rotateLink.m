function [] = rotateLink(link, deg)

%convert to radian
rad = deg2rad(deg);

XData = get(link, 'XData'); %[x1, x2]
YData = get(link, 'YData'); %[y1, y2]

%translation of link base (start point) to center
T = [-XData(1); -YData(1)];

%rotation matrix
R = [cos(rad), -sin(rad); sin(rad), cos(rad)];


%rotate end joint at center of coordinate frame, then translate back
linkEnd = [XData(2); YData(2)];

linkEnd = -T + R * (T + linkEnd);

%update link
set(link, 'XData', [XData(1), linkEnd(1)]);
set(link, 'YData', [YData(1), linkEnd(2)]);

end