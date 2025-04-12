clc; clearvars; close all
addpath(fullfile(pwd, '..', 'functions'));
video = 'n';
stack = 'n';
linhas = 'n';
fundoCor = '#2a2a2a'; % #1D1C1A 
bcolor = [255 255 255]; 
swcolor = 'n';
sccirclw = 3;
itvln = 1;
tsks = 10;
period = 0.1;

[fig, circ, radius] = scenebgm('light', fundoCor, 1080, 1080, ...
    100, 1, sccirclw, false, 'circle', false);

if video == 's'
    v = sv('newjust1frame');
end

% ====== variables ====== %
tr = 42.5;
tht = linspace(0,2*pi,100);
scalc = 148 * 60;
step = (2*pi)/(scalc);
th = 0:step:2*pi;
r = tr*(1 + cos(4*th+pi) + sin(4*th+pi).^2);
nobjs = 21;
br = 3;

precmap = colormap('cool');
whitecmap = ones(size(precmap));
whitelvl = 0.5; 
pastel= whitelvl * whitecmap + (1 - whitelvl) * precmap;

cmap = colormap(pastel);
coloridx = round(linspace(size(cmap, 1), 1, nobjs)); 

tang = zeros(1, nobjs);
astep = 2*pi/length(th) * (1:nobjs);

soundfms = cell(1,nobjs);
panfms = cell(1,nobjs);
% ======== plots ======== %
[xf, yf] = pol2cart(th, r);
f = fill(xf, yf, [1 1 1]);
p = polar(th,r);
f.FaceAlpha = 0.1;
p.LineWidth = 2;
p.Color = 'w';
sct(1) = scatter(0, 0, 80, 'filled', 'k');
sct(2) = scatter(60, 60, 80, 'filled', 'k');
sct(3) = scatter(-60, 60, 80, 'filled', 'k');
sct(4) = scatter(-60, -60, 80, 'filled', 'k');
sct(5) = scatter(60, -60, 80, 'filled', 'k');
for i = 1:5
    sct(i).LineWidth = 0.6;
    sct(i).MarkerEdgeColor = 'k';
    sct(i).MarkerFaceColor = [0.25 0.75 0.75];
end
for i = 1:nobjs
    bs(i) = circlebgm(br, [0 0], 2.5, cmap(coloridx(i), :), 1);
    lines = linecmap(nobjs, cmap, 2, 2, coloridx, itvln);
end
% ======================= %

waterwhite('circle', false, 0, 0, 1);
tamsim = length(th);
for j = 1:600
    for i = 1:nobjs
        idx = mod(j*i, tamsim);
        if idx == 0
            idx = tamsim;
        end
        %if j == 1
            %blkbgm(bs(i), tsks, swcolor, bcolor, period);  
            %soundfms{i} = [soundfms{i} j];
        %end
        cx = r(idx)*cos(th(idx));
        cy = r(idx)*sin(th(idx));
        x = br * cos(tht) + cx;
        y = br * sin(tht) + cy;
        xpos(i) = cx;
        ypos(i) = cy;
        %uplinecmap(lines, i, xpos, ypos, cmap, br, coloridx, itvln);
        set(bs(i), 'XData', x, 'YData', y);

        %panval = cx / 85;
        %panfms{i} = [panfms{i} panval];

        tang(i) = tang(i) + astep(i);
        if j < tamsim
            if tang(i) >= pi/4
                tang(i) = tang(i) - pi/4;
                blkbgm(bs(i), tsks, swcolor, bcolor, period, 0);  
                if isempty(soundfms{i})
                    soundfms{i} = j;
                else
                    soundfms{i} = [soundfms{i} j];
                end
            end
        end

        if j == tamsim
            blkbgm(bs(i), tsks/2, swcolor, bcolor, period, 0);  
            pause(0.01);
            soundfms{i} = [soundfms{i} tamsim];
        end

        if strcmp(stack,'s')
            uistack(bs(i), 'top');
        end
    end
    drawnow;
    if strcmp(video,'s')
        gf(v,fig);
    end
end
if strcmp(video,'s')
%    endsec(2,v,fig);
    cv(v);
end
