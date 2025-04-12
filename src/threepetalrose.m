clc; clearvars; close all
addpath(fullfile(pwd, '..', 'functions'));
video = 'n';
stack = 'n';
testing = 'n';
linhas = 's';
fundoCor = '#e0a9fc';
backgroundColor = [166 166 255]; 
switchColor = 'n';

regular = 'n';

[fig, circ, radius] = scenebgm('light', fundoCor, 1080, 1080, 100, 1, 2, 1, 'circle', 0);

axis equal
if video == 's'
    v = sv('rosacea');
end

startColor = [1, 1, 0]; 
endColor = [1, 0, 1];

nBahls = 20;
velocidad = 0.0004;
t = 0:velocidad:2*pi;
r = 90 * cos(3*t);
trajR = 90;
balls = cell(1, nBahls);
ball = cell(1, nBahls);
ballRadius = 15;
if testing ~= 's'
    p = polar(t, r, 'k');
    p.LineWidth = 1;
end
 
colorGradient = zeros(nBahls, 3);
for i = 1:3
    colorGradient(:, i) = linspace(startColor(i), endColor(i), 20);
end

lines = cell(1,nBahls);
ballPos = cell(1,nBahls);
ballRad = 3.5;

line([r(1)*cos(t(1)) 100], [0 0], 'Color', [0 0 0 1], 'LineWidth', 2)
pontoRad = 2.25;
thetaa = linspace(0,2*pi,5);
centerXa = r(1)*cos(t(1)); 
centerYa = r(1)*sin(t(1)); 
xa = pontoRad * cos(thetaa) + centerXa; 
ya = pontoRad * sin(thetaa) + centerYa; 
fill(xa, ya, 'k', 'EdgeColor', 'k');

theta = linspace(0, 2*pi, 100); 
for i = 1:nBahls
    ballPos{i} = [r(1)*cos(t(1)), r(1)*sin(t(1))];
    if i > 1
        lines{i} = line([ballPos{i-1}(1), ballPos{i}(1)], ...
            [ballPos{i-1}(2), ballPos{i}(2)], 'Color', [0 0 0 0.5]);
    end
    centerX = ballPos{i}(1); 
    centerY = ballPos{i}(2); 
    x = ballRad * cos(theta) + centerX; 
    y = ballRad * sin(theta) + centerY; 
    balls{i} = fill(x, y, colorGradient(i, :), 'EdgeColor', 'k');
end

totalAngle = zeros(1, nBahls);
angleStep = 2*pi/length(t) * (1:nBahls); 

if regular ~= 's'
    set(gca, 'XDir', 'reverse')
    view([90 90])
end

somArray = cell(1,nBahls);

waterblack('circle',0,0,0,1);
tamSim = length(t)/2;
for j = 1:tamSim
    if testing ~= 's'
        if j == 1
            for alphaVal = 0:0.005:1
                p.Color(4) = alphaVal;
                pause(0.01);
                if video == 's'
                    gf(v,fig);
                end
            end
            for alphaVal = 1:-0.01:0
                p.Color(4) = alphaVal;
                pause(0.01);
                if video == 's'
                    gf(v,fig);
                end
            end
        end
    end
    if ~ishandle(fig)
        break;
    end
    for i = 1:nBahls
        if j == 1
            blkbgm(balls{i}, 60, switchColor, backgroundColor, 15, 1);
            somArray{i} = [somArray{i} j];
        end
        if ~ishandle(fig)
            break;
        end
        idx = mod(j*i, tamSim);
        if idx == 0
            idx = tamSim;
        end
        centerX = r(idx)*cos(t(idx));
        centerY = r(idx)*sin(t(idx)); 
        x = ballRad * cos(theta) + centerX; 
        y = ballRad * sin(theta) + centerY; 
        set(balls{i}, 'Vertices', [x(:), y(:)]);
        totalAngle(i) = totalAngle(i) + angleStep(i);
        if totalAngle(i) >= pi
            totalAngle(i) = totalAngle(i) - pi; 
            if isempty(somArray{i})
                somArray{i} = j;
            else
                somArray{i} = [somArray{i} j];
            end
            if j < tamSim-1
                blkbgm(balls{i}, 60, switchColor, backgroundColor, 60, 1);
            end
        end
        if linhas == 's'
            index = 1;
            newBallPos = [r(idx)*cos(t(idx)), r(idx)*sin(t(idx))];
            if i > index
                dirX = newBallPos(1) - ballPos{i-1}(1); 
                dirY = newBallPos(2) - ballPos{i-1}(2);
                dirLen = sqrt(dirX^2 + dirY^2);
                dirX = dirX / dirLen;
                dirY = dirY / dirLen;   
                startX = ballPos{i-1}(1) + dirX * ballRad; 
                startY = ballPos{i-1}(2) + dirY * ballRad;
                endX = newBallPos(1) - dirX * ballRad;
                endY = newBallPos(2) - dirY * ballRad;
                set(lines{i}, 'XData', [startX, endX], 'YData', [startY, endY]); 
                if dirLen >= ballRad*2
                    set(lines{i}, 'Visible', 'on');
                else
                    set(lines{i}, 'Visible', 'off')
                end
            end
            ballPos{i} = newBallPos;
        end
        if stack == 's'
            uistack(balls{i}, 'top')
        end
        if j == tamSim
            blkbgm(balls{i}, 15, switchColor, backgroundColor, 15, 1);
            pause(0.01);
            if ~isempty(somArray{i}) && somArray{i}(end) ~= tamSim
                somArray{i} = [somArray{i} tamSim];
            end
        end
    end    
    drawnow
    if video == 's'
        gf(v,fig);
    end
end
if video == 's'
    addEndSec(10, v, fig); 
    cv(v);
end

framesArray = genArray(nBahls, 'newpath', somArray);
genAudio(framesArray, 'C:\\Users\\bvg04\\MATLAB\\A NOVA HERA\\media\\rosaceaSons\\', 60, 5, 10);
