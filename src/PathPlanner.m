classdef PathPlanner < handle
    properties
        start
        goal
        path
    end
    
    methods
        function defineWspacePath(obj, start, goal, workSpace)
            if(any(start < [0,0])==1 || any(start > [workSpace.xMax, workSpace.xMin])==1 ...
                    || any(goal < [0,0])==1 || any(goal > [workSpace.xMax, workSpace.xMin])==1)
                error('start/goal coordinates not in range of workspace')
            end
            obj.start = start;
            obj.goal = goal;
        end
        
        function defineCspacePath(obj, start, goal, configSpace)
            if(any(start < [0,0])==1 || any(start > size(configSpace.collisionData))==1 ...
                    || any(goal < [0,0])==1 || any(goal > size(configSpace.collisionData))==1)
                error('start/goal coordinates not in range of configuration space')
            end
            if(configSpace.collisionData(start(1), start(2)) == 1 ...
                    || configSpace.collisionData(start(1), start(2)) == 1)
                error('start/goal coordinates lie inside an obstacle')
            end
            obj.start = start;
            obj.goal = goal;
        end
        
        function bug1(obj, configSpace, start, goal)
            obj.defineCspacePath(start, goal, configSpace);
            %TODO
            obj.path = {};
        end
        
        function bug2(obj, configSpace, start, goal)
            defineCspacePath(start, goal, configSpace);
            %TODO
            obj.path = {};
        end
    end
    
    methods(Static)
        
    end
    
end