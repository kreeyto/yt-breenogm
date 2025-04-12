% HEARTBGM  Draws a heart shape using a parametric equation and patch.
%
%   heart = heartbgm(scale, center, lwidth, color, faceAlpha)
%
%   Inputs:
%       scale      - Scaling factor for the heart size
%       center     - [x, y] position for the heart's center
%       lwidth     - Line width of the heart’s edge
%       color      - RGB triplet or color name for the heart
%       faceAlpha  - Transparency of the heart fill (0 to 1)
%
%   Output:
%       heart      - Handle to the created heart-shaped patch
%
%   Description:
%       This function generates a classic heart shape using parametric equations:
%           x(t) = 16·sin³(t)
%           y(t) = 13·cos(t) - 5·cos(2t) - 2·cos(3t) - cos(4t)
%
%       The shape is scaled and translated according to the inputs, and rendered
%       using MATLAB’s `patch` function for smooth animation compatibility.
%
%   See also: PATCH, CIRCLEBGM, SQUAREBGM, SCENEBGM

function heart = heartbgm(scale, center, lwidth, color, faceAlpha)
    x = center(1);
    y = center(2);
    th = linspace(0, 2*pi, 1000);
    heartX = scale * (16*sin(th).^3) + x;
    heartY = scale * (13*cos(th) - 5*cos(2*th) - 2*cos(3*th) - cos(4*th)) + y;
    heart = patch(heartX, heartY, color, 'EdgeColor', color, 'LineWidth', lwidth, ...
        'FaceColor', color, 'FaceAlpha', faceAlpha);
end
