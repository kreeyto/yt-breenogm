% PATCHCMAP  Creates a matrix of patch lines with interpolated colormap gradients.
%
%   patches = patchcmap(size, cmap, coloridx, itvln, lwth)
%
%   Inputs:
%       size      - Number of objects (defines a size x size matrix of patches)
%       cmap      - Colormap (Nx3 matrix of RGB values)
%       coloridx  - Array mapping each object to a colormap index
%       itvln     - Start index offset for creating color transitions
%       lwth      - Line width of the patch edges
%
%   Output:
%       patches   - Cell array (size x size) of patch handles, initialized with
%                   color interpolation between coloridx(i-itvln) and coloridx(i)
%
%   Description:
%       For each pair of objects (i, j), where `i > itvln`, the function creates
%       a patch-based line with color smoothly interpolated from one state to another.
%       These lines are invisible at first (`XData = [0,0]`), and are meant to be
%       updated dynamically during animation to represent evolving connections.
%
%       Color blending is done using `FaceVertexCData` and `EdgeColor = 'interp'`.
%
%   See also: PATCH, LINECMAP, PATCHCMAPSTATIC

function patches = patchcmap(size, cmap, coloridx, itvln, lwth)
    patches = cell(size, size);
    for i = 1:size    
        if i > itvln
            x = [0, 0];
            y = [0, 0];
            color = [cmap(coloridx(i-itvln), :); cmap(coloridx(i), :)];
            for j = 1:i-1
                patches{i, j} = patch('XData', x, 'YData', y, 'FaceVertexCData', color, 'FaceColor', 'none', 'EdgeColor', 'interp', 'LineWidth', lwth);
            end
        end
    end
end
