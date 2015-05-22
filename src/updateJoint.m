%sticks link1 to link2
%use case: link1 has moved, position of link2 needs to be adjusted
%re-arranges link2 as if it "really" moved with link1
function [] = updateJoint(link1, link2)

XData1 = get(link1, 'XData'); %[x1, x2]
YData1 = get(link1, 'YData'); %[y1, y2]

XData2 = get(link2, 'XData'); %[x1, x2]
YData2 = get(link2, 'YData'); %[y1, y2]

%translation is based on end of link1 (joint)
T = [-(XData2(1)-XData1(2)); -(YData2(1)-YData1(2))];

link2Start = T + [XData2(1); YData2(1)];
link2End = T + [XData2(2); YData2(2)];

%update link2
set(link2, 'XData', [link2Start(1), link2End(1)]);
set(link2, 'YData', [link2Start(2), link2End(2)]);

end
