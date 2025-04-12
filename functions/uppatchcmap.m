% UPPATCHCMAP  Updates patch-based colored connections between objects.
%
%   uppatchcmap(patches, loopidx, objposX, objposY, cmap, brad, coloridx, itvln, every)
%
%   Inputs:
%       patches   - Cell array of patch handles (usually size x size)
%       loopidx   - Current index in the animation loop
%       objposX   - X-positions of the objects
%       objposY   - Y-positions of the objects
%       cmap      - Colormap used for color interpolation
%       brad      - Radius of the objects (to offset line endpoints)
%       coloridx  - Array mapping objects to colormap rows
%       itvln     - Interval to connect to previous object (if `every` is false)
%       every     - Boolean flag; true to connect with all previous objects
%
%   Description:
%       This function draws color-interpolated patch lines from the current object
%       (`loopidx`) to either:
%         - A specific earlier object (using `itvln`), or
%         - All previous objects (if `every == true`)
%
%       Each patch's visibility and color is updated dynamically based on distance.
%
%   See also: PATCHCMAP, PATCH, LINECMAP, UPLINECMAP

function uppatchcmap(patches, loopidx, objposX, objposY, cmap, brad, coloridx, itvln, every)
    if loopidx > itvln
        if every
            for i = 1:loopidx-1
                points(patches, loopidx, i, objposX, objposY, cmap, brad, coloridx);
            end
        else
            points(patches, loopidx, loopidx-itvln, objposX, objposY, cmap, brad, coloridx);
        end
    end
end

% POINTS  Internal helper function to update a patch line between two objects.
%
%   points(patches, loopidx, i, objposX, objposY, cmap, brad, coloridx)
%
%   Description:
%       Calculates the directional vector from object `i` to `loopidx`,
%       offsets the endpoints by `brad`, and sets the patch data and color.
%       If the objects are too close, the patch is hidden.

function points(patches, loopidx, i, objposX, objposY, cmap, brad, coloridx)
    dx = objposX(loopidx) - objposX(i); 
    dy = objposY(loopidx) - objposY(i);
    dl = sqrt(dx^2 + dy^2);
    if dl >= brad*2
        dx = dx / dl;
        dy = dy / dl;   
        startX = objposX(i) + dx * brad; 
        startY = objposY(i) + dy * brad;
        endX = objposX(loopidx) - dx * brad;
        endY = objposY(loopidx) - dy * brad;
        x = [startX, endX];
        y = [startY, endY];
        color = [cmap(coloridx(i), :); cmap(coloridx(loopidx), :)];
        set(patches{loopidx, i}, 'XData', x, 'YData', y, 'FaceVertexCData', color);
        set(patches{loopidx, i}, 'Visible', 'on');
    else
        set(patches{loopidx, i}, 'Visible', 'off');
    end
end
