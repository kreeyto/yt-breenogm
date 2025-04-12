% LINESTATIC  Creates a set of static, pre-initialized lines with fixed color and width.
%
%   lines = linestatic(size, color, lwth)
%
%   Inputs:
%       size   - Total number of lines to create
%       color  - Line color (RGB triplet or color string)
%       lwth   - Line width
%
%   Output:
%       lines  - Cell array of line handles, each initialized at [0,0]
%
%   Description:
%       This function creates `size` number of line objects positioned at [0,0].
%       These lines are intended to be updated dynamically during animation,
%       but initialized here with their visual properties set (color and thickness).
%
%   See also: LINE, LINESIMPLE, LINECMAP

function lines = linestatic(size, color, lwth)
    for i = 1:size    
        x = [0, 0];
        y = [0, 0];
        lines{i} = line(x, y, 'Color', color, 'LineWidth', lwth);
    end
end
