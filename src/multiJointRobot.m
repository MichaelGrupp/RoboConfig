%clear existing windows - FULLSCREEN!!!!!!!
close all; figure('units','normalized','outerposition',[0 0 1 1])

%workspace dimensions
xMax = 130;
yMax = 100;
axis([0 xMax 0 yMax])

%robot
base = [30,50];
link1Length = 20; link2Length = 10; link3Length = 20; link4Length = 10;
link5Length = 5; link6Length = 15; link7Length = 30; link8Length = 20; 

maxAngle = 720; step = 1;

link1Start = base;  link1End = [link1Start(1)+link1Length,50];
link2Start = [link1End(1),50];  link2End = [link2Start(1)+link2Length,50];
link3Start = [link2End(1),50];  link3End = [link3Start(1)+link2Length,50];
link4Start = [link3End(1),50];  link4End = [link4Start(1)+link2Length,50];
link5Start = [link4End(1),50];  link5End = [link5Start(1)+link2Length,50];
link6Start = [link5End(1),50];  link6End = [link6Start(1)+link2Length,50];
link7Start = [link6End(1),50];  link7End = [link7Start(1)+link2Length,50];
link8Start = [link7End(1),50];  link8End = [link8Start(1)+link2Length,50];

link1 = line([link1Start(1), link1End(1)], [link1Start(2), link1End(2)], 'LineWidth', 3);
link2 = line([link2Start(1), link2End(1)], [link2Start(2), link2End(2)], 'LineWidth', 3);
link3 = line([link3Start(1), link3End(1)], [link3Start(2), link3End(2)], 'LineWidth', 3);
link4 = line([link4Start(1), link4End(1)], [link4Start(2), link4End(2)], 'LineWidth', 3);
link5 = line([link5Start(1), link5End(1)], [link5Start(2), link5End(2)], 'LineWidth', 3);
link6 = line([link6Start(1), link6End(1)], [link6Start(2), link6End(2)], 'LineWidth', 3);
link7 = line([link7Start(1), link7End(1)], [link7Start(2), link7End(2)], 'LineWidth', 3);
link8 = line([link8Start(1), link8End(1)], [link8Start(2), link8End(2)], 'LineWidth', 3);

%funky part starts here
while(1)
k = waitforbuttonpress;
set(link1, 'Color', 'y');  set(link2, 'Color', 'm');  set(link3, 'Color', 'c'); set(link4, 'Color', 'g');
set(link5, 'Color', 'r');  set(link6, 'Color', 'b');  set(link7, 'Color', 'y'); set(link8, 'Color', 'm');
title('funky bot', 'FontSize', 70, 'FontName', 'Comic Sans MS')
set(gca, 'FontSize', 20, 'FontName', 'Comic Sans MS');

for i = 1:step:maxAngle
rotateLink(link1, 1);
rotateLink(link2, 2);
rotateLink(link3, -3);
rotateLink(link4, 2);
rotateLink(link5, -5);
rotateLink(link6, 2);
rotateLink(link7, 3);
rotateLink(link8, -1);

updateJoint(link1, link2);
updateJoint(link2, link3);
updateJoint(link3, link4);
updateJoint(link4, link5);
updateJoint(link5, link6);
updateJoint(link6, link7);
updateJoint(link7, link8);

if(mod(i,7)==0)
    r=rand; g=rand; b=rand;
    whitebg([r, g, b])
end
pause(0.01);
end

%go back to serious mode
title('')
set(gca, 'FontSize', 10, 'FontName', 'Helvetica');
whitebg('white')
set(link1, 'Color', 'b');  set(link2, 'Color', 'b');  set(link3, 'Color', 'b'); set(link4, 'Color', 'b');
set(link5, 'Color', 'b');  set(link6, 'Color', 'b');  set(link7, 'Color', 'b'); set(link8, 'Color', 'b');
end
pause(2.5);
close all;