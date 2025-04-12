% UPLINESIMPLE  Updates a static-colored connecting line between two moving objects.
%
%   uplinesimple(lines, idx, objposX, objposY, color, brad, itvln)
%
%   Inputs:
%       lines     - Cell array of line handles
%       idx       - Current index in the animation loop
%       objposX   - Vector of x-positions of each object
%       objposY   - Vector of y-positions of each object
%       color     - Fixed RGB color or color string for the line
%       brad      - Radius of the objects (used to offset line endpoints)
%       itvln     - Offset interval between connected objects
%
%   Description:
%       This function draws a line between object `idx` and `idx - itvln`, with endpoints
%       offset by the object radius to avoid overlap. The line is only shown if the distance
%       between the objects is at least `2 * brad`, otherwise it is hidden.
%
%   Notes:
%       - Unlike `uplinecmap`, this version uses a single fixed color for all lines.
%       - Intended for use in animation loops where object positions are updated per frame.
%
%   See also: UPLINECMAP, LINE, LINESIMPLE

function uplinesimple(lines, idx, objposX, objposY, color, brad, itvln)
    if idx > itvln
        dx = objposX(idx) - objposX(idx-itvln); 
        dy = objposY(idx) - objposY(idx-itvln);
        dl = sqrt(dx^2 + dy^2);
        dx = dx / dl;
        dy = dy / dl;   
        startX = objposX(idx-itvln) + dx * brad; 
        startY = objposY(idx-itvln) + dy * brad;
        endX = objposX(idx) - dx * brad;
        endY = objposY(idx) - dy * brad;
        set(lines{idx}, 'XData', [startX, endX], 'YData', [startY, endY], 'Color', color); 
        if dl >= brad*2
            set(lines{idx}, 'Visible', 'on');
        else
            set(lines{idx}, 'Visible', 'off');
        end
    end
end
