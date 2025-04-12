% BALLINSIDECHECK  Detects whether a ball is touching the inner boundary.
%
%   colout = BALLINSIDECHECK(gendist, radius)
%
%   This function returns a boolean flag indicating if a ball is close
%   enough to the inner circular wall to be considered in collision.
%
%   Inputs:
%       gendist - Distance from the ball to the center
%       radius  - Radius of the inner boundary
%
%   Output:
%       colout  - Logical value (true if collision is detected)
%
%   Description:
%       A simple threshold check: if the ball’s distance from the center
%       exceeds (radius - 1.5), it's considered in contact with the inner wall.
%       This function is purely for detection and does not alter velocities.
%
%   See also: BALLINSIDE, BALLOUTSIDECHECK

function colout = ballinsidecheck(gendist, radius)
    colout = false;
    if gendist >= radius-1.5
        colout = true;
    end
end
