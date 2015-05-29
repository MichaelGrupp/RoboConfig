classdef Workspace < handle
    properties
        xMax
        yMax
        obstacleHandles
        obstaclePositions
    end
    
    methods
        function init(obj, xMax, yMax)
            obj.xMax = xMax;
            obj.yMax = yMax;
            obj.obstacleHandles = {};
            obj.obstaclePositions = zeros(0, 4);
            axis([0 xMax 0 yMax])
        end
        function randomObstacles(obj, amount)
            for i=1:1:amount
                h = Workspace.randomObstacle(obj.xMax, obj.yMax);
                obj.obstacleHandles = [obj.obstacleHandles, h];
                obj.obstaclePositions = [obj.obstaclePositions; get(h, 'Position')];
            end
        end
    end
        
    methods(Static)
        %generate a rectangle in the robot workspace
        %xMax, yMax - boundaries of workspace
        %return: h - handle to rectangle object
        function [h] = randomObstacle(xMax, yMax)
            %random location within boundaries
            %x,y is lower left corner of rectangle
            x = xMax*rand;%rand between 0 and 1
            y = yMax*rand;
            %random width and height
            width = (xMax-x)*rand;
            height = (yMax-y)*rand;
            h = rectangle('Position',[x y width height],'FaceColor','r');
        end
    end

end