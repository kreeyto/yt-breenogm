clc; clearvars; close all
addpath(fullfile(pwd, 'functions'));
addpath(fullfile(pwd, 'functions'));
video = 'n';
stack = 'n';
linhas = 'n';
fundoCor = '#0f0f0f';   
bcolor = [255 255 255]; 
swcolor = 'n';
sccirclw = 3;
tsks = 480;
period = 0.25;
itvln = 1;
every = 1;

[fig, circ, radius] = scenebgm('light', fundoCor, 1920, 1080, ...
    100, 1, sccirclw, false, 'circle', false);

if video == 's'
    v = sv('ringyif');
end

% ====== variables ====== %
ttsec = 19*60 + 55; 
ttfms = ttsec * 60; 
step = (14*pi) / (ttfms); 
tht = linspace(0,2*pi,100);
th = 0:step:14*pi;
scale = 9;
r = scale*(10 + sin(2*pi*th+pi/2));
nobjs = 10;
br = 3.5;
cmap = colormap('cool');
coloridx = round(linspace(size(cmap, 1), 1, nobjs)); 
tang = zeros(1, nobjs);
astep = 14*pi/length(th) * (1:nobjs);
soundfms = cell(1,nobjs);
panfms = cell(1,nobjs);
% ======== plots ======== %
thp = 0:0.001:14*pi;
rp = scale*(10 + sin(2*pi*thp+pi/2));
p = polar(thp,rp); 
p.LineWidth = 1;
p.Color = 'w';
for i = 1:nobjs
    bs(i) = circlebgm(br, [0 0], 2, cmap(coloridx(i), :), 1);
    patches = patchcmap(nobjs, cmap, coloridx, itvln, 2);
end
% ======================= %

waterwhite('circle', false, -0.35, 0.75, 1);
tamsim = length(th);
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
        cx = r(idx)*cos(th(idx));
        cy = r(idx)*sin(th(idx));
        x = br * cos(tht) + cx;
        y = br * sin(tht) + cy;
        linex(i) = cx;
        liney(i) = cy;
        set(bs(i), 'XData', x, 'YData', y);
        uppatchcmap(patches, i, linex, liney, cmap, br, coloridx, itvln, every);

        panval = cx / 99;
        panfms{i} = [panfms{i} panval];

        tang(i) = tang(i) + astep(i);
        if tang(i) >= pi/2
            tang(i) = tang(i) - pi/2;
            if j < tamsim
                %blkbgm(bs(i), tsks, swcolor, bcolor, period, false);
                soundfms{i} = [soundfms{i} j];
            end
        end
        if j == tamsim
            %blkbgm(bs(i), tsks/4, swcolor, bcolor, period, false);
            pause(0.01);
            soundfms{i} = [soundfms{i} j];
        end
    end
    drawnow;
end
