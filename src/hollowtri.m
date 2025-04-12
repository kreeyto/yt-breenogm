clc; clearvars; close all
addpath(fullfile(pwd, '..', 'functions'));
video = 'n';
[fig, circ, raio] = scenebgm('dark', '#3266a8', 800, 800, ...
    100, 1, 2.5, true, 'circle', true);

if video == 's'
    v = sv('newcell');
end

ogax = gca;
tinyrad = 50;
th = 2*pi/200; 
radius = 100-0.75;
pausetime = 0.01;
waterwhite('circle',true,0,0,1);
for i = 1:1
    if video == 's'
        for j = 1:120 
            gf(v,fig);
        end
    end
    axes(ogax); %#ok<LAXES>
    for ang = pi/2:th:2*pi+pi/2
        if ~ishandle(fig)
            break;
        end
        topvtx = radius*[cos(ang) sin(ang)];
        leftbs = -tinyrad*[cos(ang+2*pi/3) sin(ang+2*pi/3)];
        line([topvtx(1) leftbs(1)],[topvtx(2) leftbs(2)],'Color','#c2f3ff') 
        pause(pausetime)
        if video == 's'
            gf(v,fig);
        end
    end
    for ang = pi/2:th:2*pi+pi/2
        if ~ishandle(fig)
            break;
        end
        topvtx = radius*[cos(ang) sin(ang)];
        rightbs = -tinyrad*[cos(ang-2*pi/3) sin(ang-2*pi/3)];
        line([topvtx(1) rightbs(1)],[topvtx(2) rightbs(2)],'Color','#c2f3ff')
        pause(pausetime)
        if video == 's'
            gf(v,fig);
        end
    end
    for ang = pi/2:th:2*pi+pi/2
        if ~ishandle(fig)
            break;
        end
        leftbs = -tinyrad*[cos(ang+2*pi/3) sin(ang+2*pi/3)];
        rightbs = -tinyrad*[cos(ang-2*pi/3) sin(ang-2*pi/3)];
        line([leftbs(1) rightbs(1)],[leftbs(2) rightbs(2)],'Color','#c2f3ff') 
        pause(pausetime)
        if video == 's'
            gf(v,fig);
        end
    end
    for ang = 2*pi+pi/2:-th:pi/2
        if ~ishandle(fig)
            break;
        end
        topvtx = radius*[cos(ang) sin(ang)];
        leftbs = -tinyrad*[cos(ang+2*pi/3) sin(ang+2*pi/3)];
        rightbs = -tinyrad*[cos(ang-2*pi/3) sin(ang-2*pi/3)];
        line([topvtx(1) leftbs(1)],[topvtx(2) leftbs(2)],'Color','#3266a8') 
        line([topvtx(1) rightbs(1)],[topvtx(2) rightbs(2)],'Color','#3266a8') 
        line([leftbs(1) rightbs(1)],[leftbs(2) rightbs(2)],'Color','#3266a8') 
        pause(pausetime)
        if video == 's'
            gf(v,fig);
        end
    end
    drawnow
end
if video == 's'
    endsec(3, v, fig) 
    cv(v);
end