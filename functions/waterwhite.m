% WATERWHITE  Adds a white watermark image to the animation scene.
%
%   waterwhite(shape, cellphone, xshift, yshift, alpha)
%
%   Inputs:
%       shape      - 'circle' or 'square', defines position preset
%       cellphone  - Boolean flag for mobile layout adjustment
%       xshift     - Horizontal shift (offset applied to default position)
%       yshift     - Vertical shift (offset applied to default position)
%       alpha      - Transparency multiplier (0 = invisible, 1 = opaque)
%
%   Description:
%       This function overlays a predefined white watermark image onto the scene.
%       It adjusts position depending on layout style (`shape`) and whether the
%       output is meant for mobile resolution (`cellphone`).
%
%       The watermark is:
%         - Read from a relative path:
%           "..\media\waterwhite.png"
%           using `fullfile` for OS compatibility:
%           fullfile('..', 'media', 'waterwhite.png')
%         - Blended using `AlphaData` with the specified `alpha`
%         - Rendered with bilinear interpolation and no visible axes
%
%   Notes:
%       - The watermark is rendered using its own invisible axes layered on top.
%       - Make sure the image path and file exist before running.
%
%   See also: WATERBLACK, IMAGE, SCENEBGM

function waterwhite(shape, cellphone, xshift, yshift, alpha)
    imgPath = fullfile(fileparts(mfilename('fullpath')), '..', 'media', 'waterwhite.png');
    [img, ~, alphachannel] = imread(imgPath);
    alphachannel = alphachannel * alpha; 
    if strcmp(shape, 'circle')
        if ~cellphone
            ax = axes('position', [0.19+xshift -0.15+yshift 0.620 0.402]);
        else
            ax = axes('position', [(0.19+xshift)/5.25 -0.15/1.25+yshift 0.620*1.5 0.402*1.5]);
        end
    elseif strcmp(shape, 'square')
        if ~cellphone
            ax = axes('position', [0.19+xshift -0.15/1.3+yshift 0.620 0.402]);
        else
            ax = axes('position', [(0.19+xshift)/5.25 -0.15/1.25+yshift 0.620*1.5 0.402*1.5]);
        end
    end
    image(img, 'AlphaData', alphachannel, 'Interpolation', 'bilinear');
    set(ax, 'Visible', 'off');
    set(ax, 'Color', 'none');
    axis(ax, 'equal');
end
