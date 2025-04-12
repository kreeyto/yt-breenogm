clc; clearvars; close all
addpath(fullfile(pwd, '..', 'functions'));
video = 'n';
stack = 'n';
linhas = 's';
fundoCor = '#dadbf7'; 
bcolor = [255 255 255]; 
swcolor = 'n';
sccirclw = 3;
tsks = 120;
period = 0.25;
itvln = 1;
every = false;

[fig, circ, radius] = scenebgm('light', fundoCor, 1080, 1080, ...
    100, 1, sccirclw, false, 'circle', true);

if video == 's'
    v = sv('infinite');
end

% ====== variables ====== %
ttsec = 59; 
ttfms = ttsec * 60; 
step = (2*pi) / (ttfms); 
tht = linspace(0,2*pi,100);
th = 0:step:2*pi;
nobjs = 14;
br = 3.5;
cmap = colormap('hsv');
coloridx = round(linspace(size(cmap, 1), 1, nobjs)); 
tang = zeros(1, nobjs);
astep = 2*pi/length(th) * (1:nobjs);
soundfms = cell(1,nobjs);
panfmsy = cell(1,nobjs);
% ======== plots ======== %
thp = 0:0.01:3*pi;
rp = 105*(sqrt(cos(2*thp)));
p = polar(thp,rp); 
sct = scatter(0, 0, 150, 'filled', 'k');
sct.LineWidth = 0.75;
sct.MarkerEdgeColor = 'k';
sct.MarkerFaceColor = [0 0 0];
p.LineWidth = 4;
p.Color = 'k';
for i = 1:nobjs
    bs(i) = circlebgm(br, [0 0], 2, cmap(coloridx(i), :), 1);
    patches = patchcmap(nobjs, cmap, coloridx, itvln, 2);
end
% ======================= %

waterblack('circle', true, 0, 0.125, 1);
tamsim = length(th);
scale = 105;
for j = 1:tamsim
    for i = 1:nobjs
        idx = mod(j*i, tamsim);
        if idx == 0
            idx = tamsim;
        end
        if j == 1
            %blkbgm(bs(i), tsks, swcolor, bcolor, period, false);
            soundfms{i} = [soundfms{i} j];
        end
        cx = scale * sin(th(idx))/(1 + cos(th(idx))^2);
        cy = scale * sin(th(idx))*cos(th(idx))/(1 + cos(th(idx))^2);
        x = br * cos(tht) + cx;
        y = br * sin(tht) + cy;
        linex(i) = cx;
        liney(i) = cy;
        set(bs(i), 'XData', x, 'YData', y);
        uppatchcmap(patches, i, linex, liney, cmap, br, coloridx, itvln, every);

        tang(i) = tang(i) + astep(i);
        if tang(i) >= pi
            tang(i) = tang(i) - pi;
            %blkbgm(bs(i), tsks, swcolor, bcolor, period, false);
            soundfms{i} = [soundfms{i} j];
        end
    end
    drawnow;
    if strcmp(video,'s')
        gf(v,fig);
    end
end
if strcmp(video,'s')
    cv(v);
end
