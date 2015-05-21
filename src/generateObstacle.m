%generate a rectangle in the robot workspace
%xMax, yMax - boundaries of workspace
%return: h - handle to rectangle object
function [h] = generateObstacle(xMax, yMax)

%random location within boundaries
%x,y is lower left corner of rectangle
x = xMax*rand;%rand between 0 and 1
y = yMax*rand;

%random width and height
width = (xMax-x)*rand;
height = (yMax-y)*rand;

h = rectangle('Position',[x y width height],'FaceColor','r');

end
