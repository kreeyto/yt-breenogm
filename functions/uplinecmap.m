% UPLINECMAP  Updates the position and color of a connecting line between two moving objects.
%
%   uplinecmap(lines, loopidx, objposX, objposY, cmap, brad, coloridx, itvln)
%
%   Inputs:
%       lines     - Cell array of line handles to update
%       loopidx   - Current index in the animation loop
%       objposX   - Vector of x-positions of each object
%       objposY   - Vector of y-positions of each object
%       cmap      - Colormap (Nx3 array of RGB values)
%       brad      - Ball radius (used to offset connection lines from centers)
%       coloridx  - Index vector mapping each object to a color in `cmap`
%       itvln     - Offset between connected objects (e.g. 1 for adjacent)
%
%   Description:
%       This function calculates the direction and distance between two objects
%       at indices `loopidx` and `loopidx-itvln`, then:
%         - Offsets the line endpoints by `brad` to avoid overlap with the object
%         - Interpolates the color between the two mapped colors in `cmap`
%         - Hides the line if the distance is less than `2 * brad`
%
%   Notes:
%       - Designed to be called inside a frame update loop
%       - Only updates if `loopidx > itvln`
%
%   See also: LINECMAP, PATCHCMAP, LINESIMPLE

function uplinecmap(lines, loopidx, objposX, objposY, cmap, brad, coloridx, itvln)
    if loopidx > itvln
        dx = objposX(loopidx) - objposX(loopidx-itvln); 
        dy = objposY(loopidx) - objposY(loopidx-itvln);
        dl = sqrt(dx^2 + dy^2);
        dx = dx / dl;
        dy = dy / dl;   
        startX = objposX(loopidx-itvln) + dx * brad; 
        startY = objposY(loopidx-itvln) + dy * brad;
        endX = objposX(loopidx) - dx * brad;
        endY = objposY(loopidx) - dy * brad;
        m = min(max(dl / (2*brad), 0), 1);
        color = (1-m) * cmap(coloridx(loopidx-itvln), :) + m * cmap(coloridx(loopidx), :);
        set(lines{loopidx}, 'XData', [startX, endX], 'YData', [startY, endY], 'Color', color); 
        if dl >= brad*2
            set(lines{loopidx}, 'Visible', 'on');
        else
            set(lines{loopidx}, 'Visible', 'off');
        end
    end
end
