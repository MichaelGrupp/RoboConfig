classdef ConfigurationSpace < handle
    properties
        collisionData
    end
    
    methods
        function init(obj, robot)
           obj.collisionData = zeros(robot.link1maxAngle, robot.link2maxAngle);
        end
        
        function generate(obj, robot, workspace, animation)
            step = 1;
            tic;
            for i = 1:step:robot.link1maxAngle
            robot.rotateLink(robot.link1, step);
            robot.updateJoints();
            if(animation)
                pause(0.001)
            end
            if (robot.linkCollides(robot.link1, workspace.obstaclePositions))
                obj.collisionData(i,:) = 1; %don't test robot.link2 if robot.link1 collided
            elseif(robot.circleCollides(robot.link2, workspace.obstaclePositions))
                for j = 1:step:robot.link2maxAngle
                    robot.rotateLink(robot.link2, step);
                    if(animation && mod(j,15)==0)
                        pause(0.001)
                    end
                    if(robot.linkCollides(robot.link2, workspace.obstaclePositions))
                        obj.collisionData(i,j) = 1;
                    end
                end
            end
            end
            toc
        end
        
        function plot(obj)
            figure;
            axis([0 size(obj.collisionData, 1) 0 size(obj.collisionData, 2)])
            contourf(obj.collisionData')
            colormap(1-gray)
            xlabel('angle link 1'); ylabel('angle link 2');
        end
    end
    
end
        