%clear existing windows
close all; hold on; animated = 1;

%workspace dimensions
xMax = 100;
yMax = 100;
axis([0 xMax 0 yMax])

%robot
base = [0,0];
link1Length = 50; link2Length = 20;
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
circle2 = circle(link2);
[Xc2, Yc2] = drawCircle(circle2);
if(animated)
    hp = plot(Xc2, Yc2, ':');
    set(hp, 'XDataSource', 'Xc2')
    set(hp, 'YDataSource', 'Yc2')
    linkdata on
end

tic;
for i = 1:step:link1maxAngle
rotateLink(link1, step);
updateJoint(link1, link2);
circle2 = circle(link2);
if(animated)
    [Xc2, Yc2]= drawCircle(circle2);
    refreshdata
    drawnow
    pause(0.001)
end
if (collisionSimple(link1, obstaclePositions))
    collisionData(i,:) = 1; %don't test link2 if link1 collided
elseif(collisionRadial(circle2, obstaclePositions))
    for j = 1:step:link2maxAngle
        rotateLink(link2, step);
        if(collisionSimple(link2, obstaclePositions))
            collisionData(i,j) = 1;
            isCollided=0;
        end
    end
end
end
toc

%plot configuration space
figure;
axis([0 link1maxAngle 0 link2maxAngle])
contourf(collisionData')
colormap(1-gray)
xlabel('angle link 1'); ylabel('angle link 2');