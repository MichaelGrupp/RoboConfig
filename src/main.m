addpath('geometry')
addpath('collisionCheck')

%clear existing windows
clear; close all; hold on; animation = 1;

%workspace with 4 random obstacles
workspace = Workspace;
workspace.init(100, 100);
workspace.randomObstacles(4);

%robot
robot = Robot;
robot.init([0,0], 50, 25, 90, 360);

%generate configuration space
configSpace = ConfigurationSpace;
configSpace.init(robot);
configSpace.generate(robot, workspace, animation);
configSpace.plot();