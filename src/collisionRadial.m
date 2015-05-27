%radial collision test
%circle: circle around a link in form [x, y, r]
%obstaclePositions: matrix with rectangle position data as rows
%return: x - 1 if circle collides
function [result] = collisionRadial(circle, obstaclePositions)

%check intersections for each obstacle
result = 0;
for i = 1:size(obstaclePositions,1)
    if(result==0)
        Pos = obstaclePositions(i,:); %[x y Pos(3) height]
        %4 sides
        XData1 = [Pos(1), Pos(1)+Pos(3)]; YData1 = [Pos(2), Pos(2)];%lower
        XData2 = [Pos(1), Pos(1)+Pos(3)]; YData2 = [Pos(2)+Pos(4), Pos(2)+Pos(4)];%top
        XData3 = [Pos(1), Pos(1)]; YData3 = [Pos(2), Pos(2)+Pos(4)];%left
        XData4 = [Pos(1)+Pos(3), Pos(1)+Pos(3)]; YData4 = [Pos(2), Pos(2)+Pos(4)];%right

        %test lower line (most likely)
        if(circleCollides(XData1, YData1, circle))
            result = 1; break
        end
        %test left line (2nd most likely)
        if(circleCollides(XData3, YData3, circle))
            result = 1; break
        end
        %test top line
        if(circleCollides(XData2, YData2, circle))
            result = 1; break
        end
        %test right line
        if(circleCollides(XData4, YData4, circle))
            result = 1; break
        end
    end
end

end