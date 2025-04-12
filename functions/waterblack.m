% WATERBLACK  Adds a black watermark image to the animation scene.
%
%   waterblack(shape, cellphone, xshift, yshift, alpha)
%
%   Inputs:
%       shape      - 'circle' or 'square', defines position preset
%       cellphone  - Boolean flag for mobile layout adjustment
%       xshift     - Horizontal shift (offset applied to default position)
%       yshift     - Vertical shift (offset applied to default position)
%       alpha      - Transparency multiplier (0 = invisible, 1 = opaque)
%
%   Description:
%       This function overlays a predefined black watermark image onto the scene.
%       The watermark adapts its position based on the chosen shape format
%       (usually circle or square layout) and whether it's rendered for mobile.
%
%       The watermark is:
%         - Read from a relative path:
%           "..\media\waterblack.png"
%           using `fullfile` for OS compatibility:
%           fullfile('..', 'media', 'waterblack.png')
%         - Blended using `AlphaData`
%         - Rendered with bilinear interpolation and no visible axes
%
%   Notes:
%       - Ensure the image path exists and the `.png` file is available.
%       - Axes used for the image are invisible and layered over the scene.
%
%   See also: IMAGE, WATERWHITE, SCENEBGM

function waterblack(shape, cellphone, xshift, yshift, alpha)
    imgPath = fullfile(fileparts(mfilename('fullpath')), '..', 'media', 'waterblack.png');
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