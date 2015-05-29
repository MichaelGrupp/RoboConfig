classdef Robot < handle
    properties
        base
        link1
        link2
        link1maxAngle 
        link2maxAngle
    end
    
    methods
        %initialization of the robot
        function init(obj, base, link1Length, link2Length, link1maxAngle, link2maxAngle)
            obj.base = base;
            obj.link1maxAngle = link1maxAngle;
            obj.link2maxAngle = link2maxAngle;
            %init robot laying on bottom of workspace
            link1Start = base;  link1End = [link1Start(1)+link1Length,0];
            link2Start = [link1End(1),0];  link2End = [link2Start(1)+link2Length,0];
            obj.link1 = line([link1Start(1), link1End(1)], ...
                [link1Start(2), link1End(2)], 'LineWidth', 3);
            obj.link2 = line([link2Start(1), link2End(1)], ...
                [link2Start(2), link2End(2)], 'LineWidth', 3);
        end
               
        %sticks link1 to link2
        %use case: link1 has moved, position of link2 needs to be adjusted
        %re-arranges link2 as if it "really" moved with link1
        function updateJoints(obj)
            XData1 = get(obj.link1, 'XData'); %[x1, x2]
            YData1 = get(obj.link1, 'YData'); %[y1, y2]
            XData2 = get(obj.link2, 'XData'); %[x1, x2]
            YData2 = get(obj.link2, 'YData'); %[y1, y2]
            %translation is based on end of link1 (joint)
            T = [-(XData2(1)-XData1(2)); -(YData2(1)-YData1(2))];
            link2Start = T + [XData2(1); YData2(1)];
            link2End = T + [XData2(2); YData2(2)];
            %update link2
            set(obj.link2, 'XData', [link2Start(1), link2End(1)]);
            set(obj.link2, 'YData', [link2Start(2), link2End(2)]);
        end
    end
    
    methods(Static)    
        %rotate one link of the robot
        function rotateLink(link, deg)
            %convert to radian
            rad = deg2rad(deg);
            XData = get(link, 'XData'); %[x1, x2]
            YData = get(link, 'YData'); %[y1, y2]
            %translation of link base (start point) to center
            T = [-XData(1); -YData(1)];
            %rotation matrix
            R = [cos(rad), -sin(rad); sin(rad), cos(rad)];
            %rotate end joint at center of coordinate frame, then translate back
            linkEnd = [XData(2); YData(2)];
            linkEnd = -T + R * (T + linkEnd);
            %update link
            set(link, 'XData', [XData(1), linkEnd(1)]);
            set(link, 'YData', [YData(1), linkEnd(2)]);
        end
        
        %define a circle around a link for radial collision test
        function [circle] = circle(link)
            calcLength = @(XData, YData) sqrt((XData(2)-XData(1))^2 + (YData(2)-YData(1))^2);
            %link parameters
            XData = get(link, 'XData'); %[x1, x2]
            YData = get(link, 'YData'); %[y1, y2]
            %radius is same as linkLength, center xc,yc at joint
            r = calcLength(XData, YData);
            xc = XData(1);
            yc = YData(1);
            circle = [xc, yc, r];
        end
        
        function res = linkCollides(link, obstaclePositions)
            res = collisionSimple(link, obstaclePositions);
        end
        
        function res = circleCollides(link, obstaclePositions)
            res = collisionRadial(Robot.circle(link), obstaclePositions);
        end
    end

end %Robot