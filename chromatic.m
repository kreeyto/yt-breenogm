clc; clearvars; close all
video = 'n';
stack = 'n';
linhas = 'n';
backolor = '#fff0f0'; 
bcolor = [255 255 255]; 
swcolor = 'n';
sccirclw = 3;
tsks = 120; 
period = 0.2; % ex 0.25
npend = 2;
itvln = 1;

[fig, circ, radius] = scenebgm('light', backolor, 1920, 1080, ...
    100, 1, sccirclw, true, 'circle', false);

if strcmp(video,'s')
    v = sv('chromaticsss');
end

% ====== variables ====== %
maxr = 3.5;
minr = 1;
sy = 0;
ey = 100-3.5;
spc = 1.10;
nobjs = round((ey - sy) / spc); 
radx = 62.5;
rady = 62.5;
hfnum = ceil(nobjs / 2);
tht = linspace(0,2*pi,100);
ttsec = 58+60+27; 
ttfms = ttsec * 60; 
step = (2*pi) / (ttfms); 
th = 0:step:2*pi;

tang = zeros(1, nobjs);
astep = 2*pi/length(th) * (1:nobjs);

lilac = [200, 162, 200] / 255; 
mintgreen = [206, 240, 204] / 255;
n = 1000; 
cmap = [linspace(lilac(1), mintgreen(1), n)', linspace(lilac(2), mintgreen(2), n)', linspace(lilac(3), mintgreen(3), n)'];
coloridx = round(linspace(size(cmap, 1), 1, nobjs));    
xl = [100, -100, NaN]; 
yl = [0, 0, NaN]; 

soundfms = cell(1,nobjs);
panfms = cell(1,nobjs);

% ======== plots ======== %
lineobj = patch(xl, yl, 'w', 'EdgeColor', [0 0 0], 'EdgeAlpha', ...
    0.25, 'FaceColor', 'w', 'LineWidth', 1.5, 'FaceAlpha', 0);
for i = 1:nobjs
    bx(i) = sy + (i-1) * spc;
    by(i) = 0;
    br(i) = minr + (maxr - minr) * (bx(i) - sy) / (ey - sy);
    bs(i) = circlebgm(br(i), [bx(i), by(i)], 2.5, ...
        cmap(coloridx(i), :), 1);
    bs(i).EdgeAlpha = 1;
    %lines = linesimple(nobjs, [0 0 0 0.25], 1, itvln);
end
% ======================= %

numloops = 3;
timesec = 2; 
framerate = 60; 
nframes = timesec * framerate; 
alpha = 0.25; 
step = alpha / (nframes/numloops);

tamsim = length(th);
waterblack('circle',false,0,0,1);
for j = 1:tamsim
    %{
    if j == 1
        for aval = 0:step:0.25
            circ.EdgeAlpha = aval*4;
            pause(0.01);
            if strcmp(video,'s')
                gf(v,fig);
            end
        end
        for aval = 0:step:0.25
            lineobj.EdgeAlpha = aval;
            pause(0.01);
            if strcmp(video,'s')
                gf(v,fig);
            end
        end
        for aval = 0:step:0.25
            [bs.FaceAlpha] = deal(aval*4);
            [bs.EdgeAlpha] = deal(aval*4);
            pause(0.01);
            if strcmp(video,'s')
                gf(v,fig);
            end
        end
    end
    %}
    for i = 1:nobjs
        %idx = mod(j*(i+mod(i,npend)*nobjs/2), tamsim);
        idx = mod(j*i, tamsim);
        if idx == 0
            idx = tamsim;
        end
        if j == 1
            %blkbgm(bs(i), tsks, swcolor, backolor, period);
            soundfms{i} = [soundfms{i} j];
        end
        cx = bx(i) * cos(th(idx));
        cy = bx(i) * sin(th(idx));
        x = br(i) * cos(tht) + cx; 
        y = br(i) * sin(tht) + cy;
        linex(i) = cx;
        liney(i) = cy;
        set(bs(i), 'XData', x, 'YData', y);

        tang(i) = tang(i) + astep(i);
        if j < tamsim
            if tang(i) >= pi
                tang(i) = tang(i) - pi;
                %blkbgm(bs(i), tsks, swcolor, backolor, period);
                soundfms{i} = [soundfms{i} j];
            end
        end

        panval = cx / radius;
        panfms{i} = [panfms{i} panval];

        %uplinesimple(lines, i, linex, liney, [0 0 0 0.25], br(i), itvln);
        if j == tamsim
            %blkbgm(bs(i), tsks/2, swcolor, backolor, period);
            pause(0.01);
            soundfms{i} = [soundfms{i} tamsim];
        end
    end
    drawnow;
    if strcmp(video,'s')
        gf(v,fig);
    end
end
if strcmp(video,'s')
    endsec(3, v, fig); 
    cv(v);
end
