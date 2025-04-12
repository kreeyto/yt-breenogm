clc; clearvars; close all
addpath(fullfile(pwd, '..', 'functions'));
video = 'n';
stack = 'n';
linhas = 'n';
backolor = '#0f0f0f'; 
bcolor = [255 255 255]; 
swcolor = 'n';
sccirclw = 3;
tsks = 60; 
period = 0.1; 
npend = 2;
itvln = 1;

[fig, circ, radius] = scenebgm('dark', backolor, 1920, 1080, ...
    100, 1, sccirclw, false, 'circle', true);

if strcmp(video,'s')
    v = sv('shortpwave');
end

% ====== variables ====== %
nobjs = 21; 
radx = 62.5;
rady = 62.5;
hfnum = ceil(nobjs / 2);
tht = linspace(0,2*pi,100);
ttsec = 59; 
ttfms = ttsec * 60; 
step = (2*pi) / (ttfms); 
th = 0:step:2*pi;

ypos = linspace(1,90,nobjs);

tang = zeros(1, nobjs);
astep = 2*pi/length(th) * (1:nobjs);

cmap = colormap('spring');
coloridx = round(linspace(size(cmap, 1), 1, nobjs)); 
%xl = [0, 0, NaN]; 
%yl = [0, 100, NaN]; 

soundfms = cell(1,nobjs);
panfms = cell(1,nobjs);
% ======== plots ======== %
%lineobj = patch(xl, yl, 'w', 'EdgeColor', [1 1 1], 'EdgeAlpha', ...
%    0.25, 'FaceColor', 'w', 'LineWidth', 1.5, 'FaceAlpha', 0);

%alph = linspace(1,0,nobjs);
for i = 1:nobjs
    bx(i) = 0;
    by(i) = ypos(i);
    br = 3;
    bs(i) = circlebgm(br, [bx(i), by(i)], 2, ...
        cmap(coloridx(i), :), 1);
    bs(i).EdgeAlpha = 1;
end

nstars = 1000;
x1 = rand(nstars, 1);
y1 = rand(nstars, 1);  
x2 = rand(nstars, 1);
y2 = rand(nstars, 1); 
x3 = rand(nstars, 1);
y3 = rand(nstars, 1);
x4 = rand(nstars, 1);
y4 = rand(nstars, 1);
xs1 = x1 * -(1920/2);
ys1 = y1 * -(1080/2);
xs2 = x2 * (1920/2);
ys2 = y2 * (1080/2);
xs3 = x3 * -(1920/2);
ys3 = y3 * (1080/2);
xs4 = x4 * (1920/2);
ys4 = y4 * -(1080/2);
it1 = rand(nstars, 1);
it2 = rand(nstars, 1);
it3 = rand(nstars, 1);
it4 = rand(nstars, 1);
scatter(xs1, ys1, 3, [it1 it1 it1], 'filled');
scatter(xs2, ys2, 3, [it2 it2 it2], 'filled');
scatter(xs3, ys3, 3, [it3 it3 it3], 'filled');
scatter(xs4, ys4, 3, [it4 it4 it4], 'filled');
% ======================= %

tamsim = length(th);
waterwhite('circle', true, 0, 0, 0.75);
for j = 1:tamsim
    for i = 1:nobjs
        idx = mod(j*i, tamsim);
        if idx == 0
            idx = tamsim;
        end

        if j == 1
            blkbgm(bs(i), tsks, swcolor, bcolor, period, true);
        end

        tang(i) = tang(i) + astep(i);
        cx = by(i) * cos(th(idx)+pi/2);
        cy = by(i) * sin(th(idx)+pi/4); 
        x = br * cos(tht) + cx; 
        y = br * sin(tht) + cy;
        set(bs(i), 'XData', x, 'YData', y);

        if tang(i) >= 2*pi
            tang(i) = tang(i) - 2*pi;
            blkbgm(bs(i), tsks, swcolor, bcolor, period, true);
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
