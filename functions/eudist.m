% EUDIST  Computes the Euclidean distance from the origin to a point (x, y).
%
%   d = eudist(x, y)
%
%   Inputs:
%       x - x-coordinate of the point
%       y - y-coordinate of the point
%
%   Output:
%       d - Euclidean distance from (0,0) to (x,y)
%
%   Description:
%       This function calculates the standard 2D Euclidean norm,
%       equivalent to the magnitude of a 2D vector.
%
%       Formula used:
%           d = sqrt(x^2 + y^2)
%
%   See also: NORM, PDIST2

function d = eudist(x, y)
    d = sqrt(x^2 + y^2);
end
