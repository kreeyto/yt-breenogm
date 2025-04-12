% UPLINESTATIC  Draws a line from a fixed central point to a moving object.
%
%   uplinestatic(lines, idx, objposX, objposY, color, brad, commonx, commony)
%
%   Inputs:
%       lines     - Cell array of line handles
%       idx       - Index of the object being connected
%       objposX   - Vector of x-positions of the objects
%       objposY   - Vector of y-positions of the objects
%       color     - RGB triplet or color string for the line
%       brad      - Radius of the object (used to offset line endpoint)
%       commonx   - x-coordinate of the fixed central point
%       commony   - y-coordinate of the fixed central point
%
%   Description:
%       This function draws a line from a fixed point (e.g., center of the scene)
%       to a moving object, stopping `brad` units before the object to avoid overlap.
%
%       The direction is computed from the central point to the object, and
%       the line is updated accordingly.
%
%   See also: UPLINESIMPLE, PATCH, LINE

function uplinestatic(lines, idx, objposX, objposY, color, brad, commonx, commony)
    dx = objposX(idx) - commonx; 
    dy = objposY(idx) - commony;
    dl = sqrt(dx^2 + dy^2);
    dx = dx / dl;
    dy = dy / dl;   
    endX = objposX(idx) - dx * brad;
    endY = objposY(idx) - dy * brad;
    set(lines{idx}, 'XData', [commonx, endX], 'YData', [commony, endY], 'Color', color); 
end
