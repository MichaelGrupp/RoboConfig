%clear existing windows
close all;

%workspace dimensions
xMax = 100;
yMax = 100;
axis([0 xMax 0 yMax])

%robot
base = [0,0];
link1Length = 60; link2Length = 30;
link1maxAngle = 90; link2maxAngle = 360; step = 1;

%init robot laying on bottom of workspace
link1Start = base;  link1End = [link1Start(1)+link1Length,0];
link2Start = [link1End(1),0];  link2End = [link2Start(1)+link2Length,0];

%MATLAB line has a strange coordinate format:
%line([x1, x2], [y1, y2])
link1 = line([link1Start(1), link1End(1)], [link1Start(2), link1End(2)], 'LineWidth', 3);
link2 = line([link2Start(1), link2End(1)], [link2Start(2), link2End(2)], 'LineWidth', 3);

%place random obstacles
obstacle1 = generateObstacle(xMax, yMax);
obstacle2 = generateObstacle(xMax, yMax);
obstacle3 = generateObstacle(xMax, yMax);
obstacle4 = generateObstacle(xMax, yMax);
obstacles = [obstacle1, obstacle2, obstacle3, obstacle4]';

%move robot and record collisions
collisionData = zeros(link1maxAngle, link2maxAngle);
tic;
for i = 1:step:link1maxAngle
rotateLink(link1, step);
isCollided = collisionSimple(link1, obstacles);
updateJoint(link1, link2);
    for j = 1:step:link2maxAngle
        rotateLink(link2, step);
        isCollided = collisionSimple(link2, obstacles);
        if(isCollided)
            collisionData(i,j) = 1;
        end
        %pause(0.0001);
    end
end
toc

%plot configuration space
figure;
axis([0 link1maxAngle 0 link2maxAngle])
contourf(collisionData')
colormap(1-gray)

