% SQCOL  Handles square-boundary collisions for a moving object.
%
%   [newpos, newvel, newh, collision] = sqcol(oldpos, newvel, timestep, ...
%       bgtamsqsz, ccd, newh, hs)
%
%   Inputs:
%       oldpos     - [x, y] current position of the object
%       newvel     - [vx, vy] velocity vector
%       timestep   - Time step for integration
%       bgtamsqsz  - Half-size of the square boundary (e.g., 100 means [-100, 100])
%       ccd        - Function handle to perform continuous collision detection
%       newh       - Handle to the object (usually a patch) to update position
%       hs         - Half-size of the visual square (for drawing)
%
%   Outputs:
%       newpos     - Updated position after possible collision
%       newvel     - Updated velocity (reflected if collision occurs)
%       newh       - Updated handle with new XData and YData
%       collision  - Boolean flag indicating if a collision occurred
%
%   Description:
%       This function simulates the motion of a square particle inside a bounded
%       square domain. If the object moves outside the allowed region, its velocity
%       is reflected accordingly and the position is corrected using a continuous
%       collision detection routine (`ccd`). The graphical object is also updated.
%
%   See also: CCD, PATCH, LINE, PLOT

function [newpos, newvel, newh, collision] = sqcol(oldpos, newvel, timestep, bgtamsqsz, ccd, newh, hs)
    collision = false;
    newpos = oldpos + newvel*timestep;
    if any(newpos < -bgtamsqsz) || any(newpos > bgtamsqsz)
        if newpos(1) < -bgtamsqsz || newpos(1) > bgtamsqsz
            newvel(1) = -newvel(1);
        end
        if newpos(2) < -bgtamsqsz || newpos(2) > bgtamsqsz
            newvel(2) = -newvel(2);
        end
        intpos = ccd(oldpos, newpos, bgtamsqsz);
        newpos = intpos;
        collision = true;
    end
    newh.XData = newpos(1) + [-hs, hs, hs, -hs, -hs];
    newh.YData = newpos(2) + [-hs, -hs, hs, hs, -hs];
end
