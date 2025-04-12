% SCENEBGM  Initializes and configures the background scene for animation.
%
%   [fig, shape, radius] = scenebgm(scene, bgcolor, width, height, ...
%       radius, monitor, shapew, drawbool, shapetype, cellphone)
%
%   Inputs:
%       scene     - Theme of the scene: "light" or "dark" (affects shape color)
%       bgcolor   - Background color (RGB triplet or color string)
%       width     - Width of the figure window in pixels
%       height    - Height of the figure window in pixels
%       radius    - Radius used for drawing the central shape
%       monitor   - 1 for main screen, 2+ for secondary screens
%       shapew    - Line width for the central shape outline
%       drawbool  - Boolean flag to enable or disable shape drawing
%       shapetype - "circle" or "square" to define the central shape
%       cellphone - Boolean flag to set up figure for a mobile resolution
%
%   Outputs:
%       fig    - Handle to the created figure
%       shape  - Handle to the central shape (patch object), if drawn
%       radius - Possibly adjusted radius (e.g., halved for squares)
%
%   Description:
%       This function sets up the main graphical scene used in the animation,
%       including figure dimensions, monitor placement, background color, and
%       optionally a central geometric shape (circle or square).
%
%       It also adapts layout if rendering for a mobile screen (e.g., vertical),
%       and applies appropriate axis scaling and hiding.
%
%   Behavior:
%       - The figure is centered on the chosen monitor.
%       - Axes are disabled, set to `equal` and `manual` for consistency.
%       - The central shape is drawn with no fill and thick edge lines.
%
%   See also: CIRCLEBGM, SQUAREBGM, HEARTBGM, PATCH

function [fig, shape, radius] = scenebgm(scene, bgcolor, width, height, ...
    radius, monitor, shapew, drawbool, shapetype, cellphone)
    if cellphone
        width = 1080/2;
        height = 1920/2;
    end
    if scene == "light"
        shapecolor = 'k';
    else
        shapecolor = 'w';
    end
    screensz = get(0, 'ScreenSize');
    figpos = [(screensz(3)-width)/2, ...
        (screensz(4)-height)/2, width, height];
    if monitor == 1
        fig = figure('Position', figpos); 
    else
        monitorpos = get(0,'MonitorPositions');
        figpos(1:2) = monitorpos(1,1:2) + [(monitorpos ...
            (1,3)-width)/2, (monitorpos(1,4)-height)/2]; 
        fig = figure('Position', figpos); 
    end
    set(gcf, 'Color', bgcolor)
    axis off
    hold on
    shape = [];
    if drawbool
        if shapetype == "circle"
            th = linspace(0, 2*pi, 1000);
            x = radius*cos(th);
            y = radius*sin(th);
            shape = patch(x, y, shapecolor, 'LineWidth', shapew, ...
                'EdgeColor', shapecolor, 'FaceColor', 'none'); 
        elseif shapetype == "square"
            radius = radius/2;
            x = [-radius, radius, radius, -radius, -radius];
            y = [-radius, -radius, radius, radius, -radius];
            shape = patch(x, y, shapecolor, 'LineWidth', shapew, ...
                'EdgeColor', shapecolor, 'FaceColor', 'none');
        end
    end
    if ~cellphone
        xlim([-radius-24, radius+24]);
        ylim([-radius-24, radius+24]);
    else
        xlim([-radius-10, radius+10]);
        ylim([-radius-10, radius+10]);
    end
    axis equal
    axis manual
    set(gca, 'Position', [0 0 1 1])    
end
