% SQUAREBGM  Draws a filled square using a patch object.
%
%   square = squarebgm(sidelen, center, lwidth, color, falpha)
%
%   Inputs:
%       sidelen  - Length of the square's side
%       center   - [x, y] coordinates of the square's center
%       lwidth   - Line width of the square's edge
%       color    - RGB triplet or color string for fill and edge
%       falpha   - Transparency level of the square's fill (0 to 1)
%
%   Output:
%       square   - Handle to the created patch object representing the square
%
%   Description:
%       This function creates a square patch centered at the specified location
%       using the provided visual properties. It draws the square with no rotation
%       (aligned to axes), using 5 vertices to ensure closure.
%
%   See also: PATCH, CIRCLEBGM, HEARTBGM, SCENEBGM

function square = squarebgm(sidelen, center, lwidth, color, falpha)
    x = center(1);
    y = center(2);
    sidehalf = sidelen / 2;
    squareX = [x - sidehalf, x + sidehalf, x + sidehalf, x - sidehalf, x - sidehalf];
    squareY = [y - sidehalf, y - sidehalf, y + sidehalf, y + sidehalf, y - sidehalf];
    square = patch(squareX, squareY, color, 'LineWidth', lwidth, ...
        'EdgeColor', color, 'FaceColor', color, 'FaceAlpha', falpha);
end
