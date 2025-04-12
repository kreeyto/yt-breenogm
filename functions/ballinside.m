% BALLINSIDE  Handles collision response when a ball hits the inner boundary.
%
%   [vxs, vys, cts, yshft, colout] = BALLINSIDE(gendist, x, y, vxs, vys, ...
%       radius, cts, yshft, i, ovlp)
%
%   This function updates the velocity and position of a ball when it hits the
%   inner boundary of a circular domain (e.g. a donut-shaped structure).
%
%   Inputs:
%       gendist - Distance from the ball to the center (magnitude of position)
%       x, y    - Coordinates of the ball relative to center
%       vxs     - Array of x-velocities of all balls
%       vys     - Array of y-velocities of all balls
%       radius  - Radius of the inner circle (collision zone)
%       cts     - Array of x-offset corrections for each ball
%       yshft   - Array of y-offset corrections for each ball
%       i       - Index of the current ball being processed
%       ovlp    - Boolean flag to apply penetration correction (overlap)
%
%   Outputs:
%       vxs     - Updated x-velocities after collision reflection
%       vys     - Updated y-velocities after collision reflection
%       cts     - Updated x-offset if overlap correction is enabled
%       yshft   - Updated y-offset if overlap correction is enabled
%       colout  - Boolean indicating if a collision occurred
%
%   Description:
%       If the ball is within a threshold distance (close to the inner wall),
%       this function calculates a reflection vector based on the surface
%       normal and updates the ball's velocity accordingly. Optionally, it
%       also resolves overlap by adjusting the position with a small offset
%       along the normal direction.
%
%   See also: BALLOUTSIDECHECK, PATCHCMAP, REVERSEBLINKEFFECT

function [vxs, vys, cts, yshft, colout] = ballinside(gendist, ...
    x, y, vxs, vys, radius, cts, yshft, i, ovlp)
    colout = false;
    if gendist >= radius-2 
        angle = atan2(y, x);
        nx = cos(angle);
        ny = sin(angle);
        scalar = vxs(i) * nx + vys(i) * ny;
        vxs(i) = vxs(i) - 2 * scalar * nx;
        vys(i) = vys(i) - 2 * scalar * ny;
        if ovlp
            overlap = (radius-2) - gendist;
            cts(i) = cts(i) + overlap * nx * 0.5;
            yshft(i) = yshft(i) + overlap * ny * 0.5;
        end
        colout = true;
    end
end


