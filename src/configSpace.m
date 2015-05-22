%clear axes
cla reset;

%workspace dimensions
xMax = 100;
yMax = 100;
axis([0 xMax 0 yMax])

%robot
base = [50,0];
link1Length = 25;
link2Length = 15;

%init robot laying on bottom of workspace
link1Start = base;
link1End = [link1Start(1)+link1Length,0];
link2Start = [link1End(1),0];
link2End = [link2Start(1)+link2Length,0];

%MATLAB line has a strange coordinate format:
%line([x1, x2], [y1, y2])
link1 = line([link1Start(1), link1End(1)], [link1Start(2), link1End(2)]);
link2 = line([link2Start(1), link2End(1)], [link2Start(2), link2End(2)]);

%place random obstacles
obstacle1 = generateObstacle(xMax, yMax);
obstacle2 = generateObstacle(xMax, yMax);
obstacle3 = generateObstacle(xMax, yMax);
obstacle4 = generateObstacle(xMax, yMax);


%move robot
tic;
for i = 1:1:30
rotateLink(link1, 6);
updateJoint(link1, link2);
    for j = 0:1:72
        rotateLink(link2, 5);
        pause(0.0001);
    end
end
toc



