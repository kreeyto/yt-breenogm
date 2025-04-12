clc; clearvars; close all
addpath(fullfile(pwd, 'functions'));
video = 'n';
linhas = 'n';
stack = 'n';
fundoCor = '#c2f9ff'; 
blinkColor = [255 255 255]; 
switchColor = 'n';
sceneCircleLine6Width = 2;
tasksBlink = 120;

[fig, circ, radius] = scenebgm('light', fundoCor, 800, 800, ...
    100, 1, 2.5, 1, 'circle', 0);

if video == 's'
    v = sv('7slash9');
end

% ====== variable def ====== %
num = 7; den = 9; trajR = 100-3.5-1;
phi = pi/2;
%th = linspace(0, den*pi, 1000);
th = 0:0.001:den*pi;
r = trajR * cos((num/den)*th);
%p = polar(th, r, 'k');
%p.LineWidth = 1.5;
% ========================== %
nb = 30;
bs = cell(1, nb);
b = cell(1, nb);
br = 3.5;
% ========================== %
sc = [1, 1, 0]; 
ec = [1, 0, 1];
cg = zeros(nb, 3);
% ========================== %
tht = linspace(0, 2*pi, 1000);
% ========================== %
tang = zeros(1, nb);
astep = den*pi/length(th) * (1:nb); 
% ========================== %

for i = 1:3
    cg(:, i) = linspace(sc(i), ec(i), nb);
end

for i = 1:7
    thxtr = (9*i*pi)/7;
    rxtr = trajR * cos((num/den)*thxtr);
    [x, y] = pol2cart(thxtr, rxtr);
    sct = scatter(x, y, 75, 'filled', 'k');
    sct.LineWidth = 0.6;
    sct.MarkerEdgeColor = 'k';
    sct.MarkerFaceColor = [0 0.5 0.5];
end

for i = 1:nb
    bpos{i} = [r(1)*cos((num/den)*th(1)), ...
        r(1)*sin((num/den)*th(1))];
    if i > 1
        %lines{i} = line([bpos{i-1}(1), bpos{i}(1)], ...
        %    [bpos{i-1}(2), bpos{i}(2)], 'Color', [0 0 0 0.5]);
        numSegments = 2;
        x = linspace(bpos{i-1}(1), bpos{i}(1), numSegments);
        y = linspace(bpos{i-1}(2), bpos{i}(2), numSegments);
        for j = 1:numSegments-1
            t = j / numSegments;
            color = (1-t) * cg(i-1, :) + t * cg(i, :);
            lines{i} = line(x(j:j+1), y(j:j+1), 'Color', color, 'LineWidth', 2);
        end
    end
    cx = bpos{i}(1); 
    cy = bpos{i}(2); 
    x = br * cos(tht) + cx; 
    y = br * sin(tht) + cy; 
    balls{i} = patch(x, y, cg(i, :), 'EdgeColor', cg(i, :), 'LineWidth', 2.5); %2.5
end

view([-90 90])

somArray = cell(1,nb);
panArray = cell(1,nb);

numloops = 2;
timesec = 4; 
framerate = 60; 
nframes = timesec * framerate; 
alpha = 1; 
step = alpha / (nframes/numloops);

waterblack('circle',0,0,0,1);
tamSim = length(th);
for j = 1:tamSim
    %{
    if j == 1
        for alphaVal = 0:step:1
            p.Color(4) = alphaVal;
            pause(0.01);
            if video == 's'
                gf(v,fig);
            end
        end
        for alphaVal = 1:-step:0
            p.Color(4) = alphaVal;
            pause(0.01);
            if video == 's'
                gf(v,fig);
            end
        end
    end
    %}
    if ~ishandle(fig)
        break;
    end
    for i = 1:nb
        if j == 1
            %blkbgm(balls{i}, tasksBlink, switchColor, blinkColor);
            somArray{i} = [somArray{i} j];
        end
        if ~ishandle(fig)
            close all; break;
        end
        idx = mod(j*i, tamSim);
        if idx == 0
            idx = tamSim;
        end
        cx = r(idx)*cos(th(idx));
        cy = r(idx)*sin(th(idx)); 
        x = br * cos(tht) + cx; 
        y = br * sin(tht) + cy; 
        set(balls{i}, 'Vertices', [x(:), y(:)]);

        tang(i) = tang(i) + astep(i);
        if tang(i) >= (9*pi/7)
            %blkbgm(balls{i}, tasksBlink, switchColor, blinkColor); % OUTDATED
            tang(i) = tang(i) - (9*pi/7); 
            if isempty(somArray{i})
                somArray{i} = j;
            else
                somArray{i} = [somArray{i} j];
            end
        end

        newbpos = [r(idx)*cos(th(idx)), r(idx)*sin(th(idx))];
        panValue = -(newbpos(2) / trajR);
        panArray{i} = [panArray{i} panValue];

        if stack == 's'
            uistack(balls{i}, 'top')
        end
        if j == tamSim
            %blkbgm(balls{i}, 30, switchColor, blinkColor); % OUTDATED
            pause(0.01);
            if ~isempty(somArray{i}) && somArray{i}(end) ~= tamSim
                somArray{i} = [somArray{i} tamSim];
            end
        end
        if linhas == 's'
            index = 1;
            if i > index
                dx = newbpos(1) - bpos{i-1}(1); 
                dy = newbpos(2) - bpos{i-1}(2);
                dl = sqrt(dx^2 + dy^2);
                dx = dx / dl;
                dy = dy / dl;   
                startX = bpos{i-1}(1) + dx * br; 
                startY = bpos{i-1}(2) + dy * br;
                endX = newbpos(1) - dx * br;
                endY = newbpos(2) - dy * br;
                set(lines{i}, 'XData', [startX, endX], 'YData', [startY, endY]); 
                if dl >= br*2
                    set(lines{i}, 'Visible', 'on');
                else
                    set(lines{i}, 'Visible', 'off');
                end
            end
            bpos{i} = newbpos;
        end
    end    
    drawnow
    if video == 's'
        gf(v,fig);
    end
end
if video == 's'
    endsec(5, v, fig); 
    cv(v);
end


