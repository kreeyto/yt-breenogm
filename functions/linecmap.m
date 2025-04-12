% LINECMAP  Draws segmented lines with interpolated colormap transitions.
%
%   lines = linecmap(size, cmap, nseg, lwth, coloridx, itvln)
%
%   Inputs:
%       size      - Total number of lines to generate
%       cmap      - Colormap array (Nx3 RGB values)
%       nseg      - Number of segments per line (controls smoothness)
%       lwth      - Line width
%       coloridx  - Array of colormap row indices for each line
%       itvln     - Line index interval to start color transitions (e.g. 1 to skip 1st line)
%
%   Output:
%       lines     - Cell array of line handles (size = `size`)
%
%   Description:
%       This function creates a set of lines where each one is built from
%       small segments, and each segment blends color between two states.
%       The color transition is interpolated between:
%           cmap(coloridx(i-itvln), :) → cmap(coloridx(i), :)
%
%       The first `itvln` entries are skipped; transitions only begin after that.
%       Each line is initialized at (0,0) and meant to be updated later with
%       dynamic positions during the animation.
%
%   Example:
%       lines = linecmap(56, jet(256), 10, 1.5, coloridx, 1);
%
%   See also: LINE, PATCH, COLORMAP

function lines = linecmap(size, cmap, nseg, lwth, coloridx, itvln)
    for i = 1:size    
        if i > itvln
            x = linspace(0, 0, nseg);
            y = linspace(0, 0, nseg);
            for j = 1:nseg-1
                t = j / nseg;
                color = (1-t) * cmap(coloridx(i-itvln), :) + t * cmap(coloridx(i), :);
                lines{i} = line(x(j:j+1), y(j:j+1), 'Color', color, 'LineWidth', lwth);
            end
        end
    end
end