% CCD  Calculates the closest contact point to the boundary of a square.
%
%   intpos = CCD(oldpos, newpos, bgtamsqsz)
%
%   This function estimates the point where a moving object (e.g. a ball)
%   would collide with the boundary of a square background.
%
%   Inputs:
%       oldpos     - [x, y] vector of the object's previous position
%       newpos     - [x, y] vector of the object's current or target position
%       bgtamsqsz  - Half-length of the square's side (i.e. distance from center to edge)
%
%   Output:
%       intpos     - [x, y] intersection point with the square boundary
%
%   Description:
%       This is a basic continuous collision detection (CCD) function.
%       It computes the movement direction from `oldpos` to `newpos`,
%       finds the minimal distance to the square’s edge in any axis,
%       and projects the movement vector until it intersects that edge.
%
%   Use case:
%       Useful for computing where to place a visual element (e.g., a line or trail)
%       when a ball moves out of bounds in a square domain.
%
%   See also: N/A

function intpos = ccd(oldpos, newpos, bgtamsqsz)
    dir = newpos - oldpos;
    dir = dir / norm(dir); 
    dists = abs(bgtamsqsz - abs(oldpos));
    [mindist, idx] = min(dists);
    intpos = oldpos + mindist * dir;
end
