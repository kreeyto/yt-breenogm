clc; clearvars; close all
addpath(fullfile(pwd, 'functions'));
video = 's';
linhas = 'n';
stack = 'n';
bckcolor = '#4a2b48'; % #382337 #4a2f49
bcolor = [255 255 255]; 
swcolor = 'n';
sccirclw = 3;
tsks = 45;
period = 0.1;
itvln = 1;
fsh = 'n';

[fig, shape, radius] = scenebgm('dark', bckcolor, 1080, 1080, ...
    100, 1, 3, false, 'circle', true);

if strcmp(video,'s')
    v = sv('valentines');
end

% ====== variable def ====== %
scalc = 59 * 60;
step = (2*pi)/(scalc);
th = 0:step:2*pi;
sfs = 6.25;
x = 16*sin(th).^3;
y = 13*cos(th) - 5*cos(2*th) - 2*cos(3*th) - cos(4*th) + 0.5;
fillclr = [85, 25, 0] / 255; 
nobjs = 21; 
br = 3.5; 

%cmap = colormap('winter');
peach = [255, 218, 185] / 255; 
softpink = [255, 105, 180] / 255;
n = 1000; 
cmap = [linspace(peach(1), softpink(1), n)', linspace(peach(2), softpink(2), n)', linspace(peach(3), softpink(3), n)'];
clridx = round(linspace(size(cmap, 1), 1, nobjs)); 

stx = sfs*x(1); 
sty = sfs*y(1); 
jhm = 1;

pth = linspace(0,2*pi,500);
px = 16*sin(pth).^3;
py = 13*cos(pth) - 5*cos(2*pth) - 2*cos(3*pth) - cos(4*pth) + 0.5;

tamsim = length(th); 
soundfms = cell(1,nobjs);
panfms = cell(1,nobjs);

tang = zeros(1, nobjs);
astep = 2*pi/length(th) * (1:nobjs);

peach = [255, 218, 185] / 255; % RGB values are divided by 255 to normalize them
softpink = [255, 192, 203] / 255;

% ========================== %

% ====== object creation ====== %
patch(sfs*x, sfs*y, fillclr, 'FaceAlpha', 0.375);
plot(sfs*px, sfs*py, 'Color', '#e31b23', 'LineWidth', 2.5);

if strcmp(fsh,'s')
    bs(1) = heartbgm(0.375, [stx, sty], 2.5, cmap(clridx(1), :), 1);
    for i = 2:nobjs
        bs(i) = circlebgm(br, [stx, sty], 2.5, cmap(clridx(i), :), 1);
        lines = linecmap(nobjs, cmap, 2, 2, clridx, jhm);
    end
else
    for i = 1:nobjs
        lines = linesimple(nobjs, [1 1 1 0.5], 2, jhm);
        bs(i) = circlebgm(br, [stx, sty], 2.5, cmap(clridx(i), :), 1);
    end
end
% ============================= %

waterwhite('circle',0,0,0,1);
for j = 1:tamsim
    if ~ishandle(fig)
        break;
    end
    for i = 1:nobjs
        idx = mod(j*i, tamsim);
        if idx == 0
            idx = tamsim;
        end
        cx = sfs*x(idx);
        cy = sfs*y(idx); 
        curx = get(bs(i), 'XData');
        cury = get(bs(i), 'YData');
        dx = cx - mean(curx);
        dy = cy - mean(cury);
        obx(i) = cx;
        oby(i) = cy;
        if linhas == 's'
            uplinesimple(lines, i, obx, oby, [1 0 0 0.5], br, jhm)
        end
        set(bs(i), 'XData', curx + dx, 'YData', cury + dy);

        panval = cx / radius;
        panfms{i} = [panfms{i} panval];
        tang(i) = tang(i) + astep(i);

        if j == 1
            blkbgm(bs(i), tsks, swcolor, bckcolor, period); 
            soundfms{i} = [soundfms{i} j];
        elseif j < tamsim && j > 1
            if tang(i) >= pi
                tang(i) = tang(i) - pi;
                blkbgm(bs(i), tsks, swcolor, bckcolor, period);  
                soundfms{i} = [soundfms{i} j];
            elseif tang(i) >= 2*pi 
                tang(i) = tang(i) - 2*pi;
                blkbgm(bs(i), tsks, swcolor, bckcolor, period); 
                soundfms{i} = [soundfms{i} j];
            end
       elseif j == tamsim
            blkbgm(bs(i), tsks, swcolor, bckcolor, period);    
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

