%clear existing windows
close all; hold on;

%workspace dimensions
xMax = 100;
yMax = 100;
axis([0 xMax 0 yMax])

%robot
base = [0,0];
link1Length = 70; link2Length = 30;
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
%pack the obstacle positions to reduce get/set overhead later
obstaclePositions = [get(obstacle1, 'Position'); get(obstacle2, 'Position');
    get(obstacle3, 'Position'); get(obstacle4, 'Position')]; 

%move robot and record collisions
collisionData = zeros(link1maxAngle, link2maxAngle);
circle1 = circle(link1);
circle2 = circle(link2);
hp1 = plot(circle1(1,:), circle1(2,:));
hp2 = plot(circle2(1,:), circle2(2,:));
set(hp1, 'XDataSource', 'circle1(1,:)')
set(hp1, 'YDataSource', 'circle1(2,:)')
set(hp2, 'XDataSource', 'circle2(1,:)')
set(hp2, 'YDataSource', 'circle2(2,:)')
linkdata on
tic;
for i = 1:step:link1maxAngle
rotateLink(link1, step);
updateJoint(link1, link2);
circle1 = circle(link1);
circle2 = circle(link2);
refreshdata
drawnow
isCollided = collisionRadial(circle1, obstaclePositions);
if(not(isCollided))
    for j = 1:step:link2maxAngle
        rotateLink(link2, step);
        isCollided = collisionRadial(circle2, obstaclePositions);
        if(isCollided)
            collisionData(i,j) = 1;
            isCollided=0;
        end
    end
else %don't test link2 if link1 collided
    collisionData(i,:) = 1;
end
end
toc

%plot configuration space
figure;
axis([0 link1maxAngle 0 link2maxAngle])
contourf(collisionData')
colormap(1-gray)
xlabel('angle link 1'); ylabel('angle link 2');

