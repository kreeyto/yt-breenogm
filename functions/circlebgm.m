% CIRCLEBGM  Draws a filled circle using a patch object.
%
%   circle = CIRCLEBGM(radius, center, lineWidth, color, faceAlpha)
%
%   This function creates a circular patch at a specified location, with
%   customizable radius, edge width, color, and transparency.
%
%   Inputs:
%       radius     - Radius of the circle
%       center     - [x, y] coordinates of the circle's center
%       lineWidth  - Width of the circle’s edge stroke
%       color      - RGB triplet or color string for fill and edge
%       faceAlpha  - Transparency level of the circle’s fill (0 to 1)
%
%   Output:
%       circle     - Handle to the created patch object
%
%   Description:
%       This utility function generates a smooth circular patch using
%       100 points evenly distributed around the circumference.
%
%   See also: PATCH, SQUAREBGM, SCENEBGM

function circle = circlebgm(radius, center, lineWidth, color, faceAlpha)
    x = center(1);
    y = center(2);
    theta = linspace(0,2*pi,100);
    circleX = radius * cos(theta) + x;
    circleY = radius * sin(theta) + y;
    circle = patch(circleX, circleY, color, 'EdgeColor', color, 'LineWidth', lineWidth, 'FaceColor', color, 'FaceAlpha', faceAlpha);
end
