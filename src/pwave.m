clc; clearvars; close all
addpath(fullfile(pwd, '..', 'functions'));
video = 'n';
linhas = 'n';
stack = 'n';
fundoCor = '#1f1f4f'; 
blinkColor = [255 255 255]; 
switchColor = 'n';
sceneCircleLineWidth = 2;
tasksBlink = 60;
periodo = 0.1;

[fig, circ, radius] = scenebgm('dark', fundoCor, 1080, 1080, 100, 1, sceneCircleLineWidth, 1, 'circle', true);

if video == 's'
    v = sv('pendulumWave');
end

donutHoleSize = 25;
th = linspace(0, 2*pi, 1000);
xD = donutHoleSize*cos(th);
yD = donutHoleSize*sin(th);
donut = patch(xD, yD, 'w', 'EdgeColor', [1 1 1], 'LineWidth', sceneCircleLineWidth, 'FaceColor', 'none');

dotR = 3.5;
centerX = 0;
centerY = 0;
theta = linspace(0, 2*pi, 100);

startY = 25-0.21875;
endY = 100-3.5;
spacing = 1.29;
numCircles = 56; % round((endY - startY) / spacing)
radx = 62.5;
rady = 62.5;
halfNum = ceil(numCircles / 2);
cmap = [linspace(0, 1, halfNum), linspace(1, 0, numCircles-halfNum+1)]' * [0 1 1] + ...
       [linspace(1, 0, halfNum), linspace(0, 1, numCircles-halfNum+1)]' * [1 0 1];

framerate = 60;
sec = 60;
frames = sec * framerate;

circleX1 = 0; circleY1 = 0; circleR1 = 100;
circleX2 = 0; circleY2 = 0; circleR2 = donutHoleSize;

adjustedR1 = circleR1;
adjustedR2 = circleR2 + 0.375;

xL = [circleX1, circleX2, NaN]; 
yL = [circleY1+adjustedR1, circleY2+adjustedR2, NaN]; 
lineObj = patch(xL, yL, 'w', 'EdgeColor', [1 1 1], 'EdgeAlpha', 0.25, 'FaceColor', 'w', 'LineWidth', 1.5, 'FaceAlpha', 0);

x1 = circleX1; y1 = circleY1+adjustedR1;
x2 = circleX2; y2 = circleY2+adjustedR2;

lines = cell(1, numCircles);
ballPos = cell(1, numCircles);

for i = 1:numCircles
    dotR(i) = 3.5;
    dotX(i) = 0;
    dotY(i) = startY + (i-1) * spacing;
    dotTheta{i} = theta;
    dot.color = cmap(i, :);
    dotXC{i} = dotR(i) * cos(dotTheta{i}) + dotX(i);
    dotYC{i} = dotR(i) * sin(dotTheta{i}) + dotY(i);
    dotPlot(i) = patch(dotXC{i}, dotYC{i}, dot.color, 'LineWidth', 2, 'EdgeColor', dot.color, 'FaceAlpha', 0, 'EdgeAlpha', 0);
    trajR(i) = dotY(i); 
    trajX(i) = 0;
    trajY(i) = 0;
    trajXC{i} = dotR(i) * cos(dotTheta{i}) + dotX(i);
    trajYC{i} = dotR(i) * sin(dotTheta{i}) + dotY(i);
    if linhas == 's'
        if i > 1
            lines{i} = line('XData', [dotX(i-1), dotX(i)], 'YData', ...
                [dotY(i-1), dotY(i)], 'Color', 'w', 'Visible', 'off');
        end
        ballPos{i} = [trajR(i)*cos(0)+trajX(i), trajR(i)*sin(0)+trajY(i)];
    end
end

t = 0:0.0003:2*pi;
totalAngle = zeros(1, numCircles);
angleStep = 2*pi/length(t) * (1:numCircles);
somArray = cell(1,numCircles);

ax = gca;
ax.XTick = []; 
ax.YTick = [];
axis off

T = 4; 
f = 60; 
N = T * f; 
A = 0.25; 
s = A / (N/2);

flag = false(1, numCircles);
waterwhite('circle',1,0,0,1);
tamSim = length(t);
for j = 1:tamSim
    if j == 1
        for alphaVal = 0:s:0.25
            lineObj.EdgeAlpha = alphaVal;
            donut.EdgeAlpha = alphaVal; 
            circ.EdgeAlpha = alphaVal * 4;
            pause(0.01);
            if video == 's'
                gf(v,fig);
            end
        end
        for alphaVal = 0:s:0.25
            for k = 1:numel(dotPlot)
                dotPlot(k).EdgeAlpha = alphaVal * 4; 
            end
            pause(0.01); 
            if video == 's'
                gf(v,fig);
            end
        end
    end
    if ~ishandle(fig)
        close all; break;
    end
    for i = 1:numCircles
        if j == 1 || flag(i)
            rvsblkbgm(dotPlot(i), tasksBlink, periodo, switchColor, blinkColor)
            flag(i) = false;
            somArray{i} = [somArray{i} j];
        end
        totalAngle(i) = totalAngle(i) + angleStep(i);
        newX = trajR(i)*cos(totalAngle(i)+pi/2)+trajX(i); 
        newY = trajR(i)*sin(totalAngle(i)+pi/2)+trajY(i);
        set(dotPlot(i), 'Vertices', [dotR(i)*cos(dotTheta{i})+newX; dotR(i)*sin(dotTheta{i})+newY]')
        if totalAngle(i) >= 2*pi
            rvsblkbgm(dotPlot(i), tasksBlink, periodo, switchColor, blinkColor)
            totalAngle(i) = totalAngle(i) - 2*pi;
            flag(i) = true;
            if isempty(somArray{i})
                somArray{i} = j;
            else
                somArray{i} = [somArray{i} j];
            end
        end
        if stack == 's'
            uistack(dotPlot(i), 'top')
        end
        if j == tamSim
            rvsblkbgm(dotPlot(i), 15, periodo, switchColor, blinkColor)
            pause(0.01);
            if ~isempty(somArray{i}) && somArray{i}(end) ~= tamSim
                somArray{i} = [somArray{i} tamSim];
            end
        end
        if linhas == 's'
            if i > 1
                newDotPos = [trajR(i)*cos(totalAngle(i)+pi/2), trajR(i)*sin(totalAngle(i)+pi/2)];
                dirX = newDotPos(1) - ballPos{i-1}(1); 
                dirY = newDotPos(2) - ballPos{i-1}(2);
                dirLen = sqrt(dirX^2 + dirY^2);
                dirX = dirX / dirLen;
                dirY = dirY / dirLen;   
                startX = ballPos{i-1}(1) + dirX * dotR(i); 
                startY = ballPos{i-1}(2) + dirY * dotR(i);
                endX = newDotPos(1) - dirX * dotR(i);
                endY = newDotPos(2) - dirY * dotR(i);
                set(lines{i}, 'XData', [startX, endX], 'YData', [startY, endY]); 
                if dirLen >= dotR(i)*2
                    set(lines{i}, 'Visible', 'on');
                else
                    set(lines{i}, 'Visible', 'off')
                end
            end
            ballPos{i} = [trajR(i)*cos(totalAngle(i)+pi/2), trajR(i)*sin(totalAngle(i)+pi/2)];
        end
    end
    drawnow;
    if video == 's'
        gf(v,fig);
    end
end
if video == 's'
    addEndSec(10, v, fig); 
    cv(v);
end

%framesArray = genArray(numCircles, "C:\\Users\\bvg04\\MATLAB\\A NOVA HERA\\media\\pwaveSons\\pwave", somArray);
%genAudio(framesArray, "C:\\Users\\bvg04\\MATLAB\\A NOVA HERA\\media\\pwaveSons\\composites\\", 60, 4, 10);
