% BALLOUTSIDECHECK  Detects whether a ball is touching the outer boundary.
%
%   colout = BALLOUTSIDECHECK(gendist, radius)
%
%   This function returns a boolean flag indicating if a ball is close
%   enough to the outer circular wall to be considered in collision.
%
%   Inputs:
%       gendist - Distance from the ball to the center
%       radius  - Radius of the outer boundary
%
%   Output:
%       colout  - Logical value (true if collision is detected)
%
%   Description:
%       If the distance to the center is less than or equal to (radius - 1.5),
%       the function considers the ball in contact with the outer boundary.
%       This is used for detection purposes only, not for handling reflection.
%
%   See also: BALLINSIDECHECK, BALLINSIDE

function colout = balloutsidecheck(gendist, radius)
    colout = false;
    if gendist <= radius-1.5
        colout = true;
    end
end
