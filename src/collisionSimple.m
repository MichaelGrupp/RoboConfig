%simple collision test
%link: handle of MATLAB line object of a robot link
%obstacles: row array of square obstacle handles
%return: x - 1 if robot collides
function [result] = collisionSimple(link, obstacles)

%y=mx+b   =>  line=slope*x+intercept

%inline function for slope calculation
slope = @(XData, YData) (YData(2) - YData(1)) / (XData(2) - XData(1));

%inline function for intercept calculation (y-axis offset)
intercept = @(XData, YData, slope) (YData(1) - slope*XData(1));

%intersection functions
isParallel = @(m1, m2, b1, b2) (m1==m2) && (b1~=b2);
xIntersect = @(m1, m2, b1, b2) (b2-b1)/(m1-m2);
yIntersect = @(m1, b1, xIntersect) m1*xIntersect+b1;
isPointInsideX = @(xIntersect, XDataLink, XDataObs) ...
    ((xIntersect >= XDataLink(1) && xIntersect <= XDataLink(2)) || ...
    (xIntersect >= XDataLink(2) && xIntersect <= XDataLink(1))) && ...
    ((xIntersect >= XDataObs(1) && xIntersect <= XDataObs(2)) || ...
    (xIntersect >= XDataObs(2) && xIntersect <= XDataObs(1)));
isPointInsideY = @(yIntersect, YDataLink, YDataObs) ...
    ((yIntersect >= YDataLink(1) && yIntersect <= YDataLink(2)) || ...
    (yIntersect >= YDataLink(2) && yIntersect <= YDataLink(1))) && ...
    ((yIntersect >= YDataObs(1) && yIntersect <= YDataObs(2)) || ...
    (yIntersect >= YDataObs(2) && yIntersect <= YDataObs(1)));
    
%link parameters
XDataLink = get(link, 'XData'); %[x1, x2]
YDataLink = get(link, 'YData'); %[y1, y2]
m = slope(XDataLink, YDataLink);
b = intercept(XDataLink, YDataLink, m);

%check intersections for each obstacle
result = 0;
for i = 1:size(obstacles)
    if(result==0)
        Pos = get(obstacles(i), 'Position'); %[x y Pos(3) height]
        %4 sides
        XData1 = [Pos(1), Pos(1)+Pos(3)]; YData1 = [Pos(2), Pos(2)];%lower
        XData2 = [Pos(1), Pos(1)+Pos(3)]; YData2 = [Pos(2)+Pos(4), Pos(2)+Pos(4)];%top
        XData3 = [Pos(1), Pos(1)]; YData3 = [Pos(2), Pos(2)+Pos(4)];%left
        XData4 = [Pos(1)+Pos(3), Pos(1)+Pos(3)]; YData4 = [Pos(2), Pos(2)+Pos(4)];%right

        %rectangle has either 0 or infinity...
        m1 = 0; b1 = intercept(XData1, YData1, m1);
        m2 = 0; b2 = intercept(XData2, YData2, m2);
        m3 = inf; b3 = intercept(XData3, YData3, m3);
        m4 = inf; b4 = intercept(XData4, YData4, m4);


        %test horizontal lines
        if(not(isParallel(m, m1, b, b1)))
            x = xIntersect(m, m1, b, b1);
            %y = yIntersect(m, b, x);
            if(isPointInsideX(x, XDataLink, XData1))
                %plot(x,y,'m*','markersize',8)
                result = 1;
            end
        end
        if(not(isParallel(m, m2, b, b2)))
            x = xIntersect(m, m2, b, b2);
            %y = yIntersect(m, b, x);
            if(isPointInsideX(x, XDataLink, XData2))
                %plot(x,y,'m*','markersize',8)
                result = 1;
            end
        end
        %test vertical lines
        if(not(isParallel(m, m3, b, b3)))
            %x = XData3(1);
            y = yIntersect(m, b, XData3(1));
            if(isPointInsideY(y, YDataLink, YData3))
                %plot(x,y,'k*','markersize',8)
                result = 1;
            end
        end
        if(not(isParallel(m, m4, b, b4)))
            %x = XData4(1);
            y = yIntersect(m, b, XData4(1));
            if(isPointInsideY(y, YDataLink, YData4))
                %plot(x,y,'k*','markersize',8)
                result = 1;
            end
        end
    end
end

end