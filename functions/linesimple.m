% LINESIMPLE  Creates a set of pre-initialized lines with fixed color and width.
%
%   lines = linesimple(size, color, lwth, itvln)
%
%   Inputs:
%       size   - Total number of lines to create
%       color  - Line color (RGB triplet or color string)
%       lwth   - Line width
%       itvln  - Starting index for line creation (lines before this are skipped)
%
%   Output:
%       lines  - Cell array containing line object handles
%
%   Description:
%       Initializes a group of vertical lines, each starting at [0,0] with no
%       length. These are placeholders meant to be updated later with real
%       coordinates. Only lines from index `itvln + 1` onward are created.
%
%   See also: LINECMAP, LINE

function lines = linesimple(size, color, lwth, itvln)
    for i = 1:size    
        if i > itvln
            x = [0, 0];
            y = [0, 0];
            lines{i} = line(x, y, 'Color', color, 'LineWidth', lwth);
        end
    end
end
