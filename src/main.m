addpath('geometry')
addpath('collisionCheck')

%clear existing figures and objects
clear; close all; animated = 0;

%workspace with 4 random obstacles
workspace = Workspace;
workspace.init(100, 100);
workspace.randomObstacles(4);

%robot
robot = Robot;
%(base, link1Length, link2Length, link1maxAngle, link2maxAngle)
robot.init([0,0], 50, 25, 90, 360);

%generate configuration space
configSpace = ConfigurationSpace;
configSpace.init(robot);
configSpace.generate(robot, workspace, animated);
configSpace.plot();

pathPlanner = PathPlanner;
start = [1,20]; goal = [40,60];
pathPlanner.bug1(configSpace, start, goal);