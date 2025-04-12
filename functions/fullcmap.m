% FULLCMAP  Generates reversed colormap indices for multiple objects.
%
%   coloridx = fullcmap(cmap, nobjs)
%
%   Inputs:
%       cmap   - A colormap matrix (Nx3), where each row is an RGB triplet
%       nobjs  - Number of objects to assign colors to
%
%   Output:
%       coloridx - Row indices into `cmap` for each object, ordered in reverse
%
%   Description:
%       This function returns a set of `nobjs` evenly spaced indices that
%       traverse the colormap `cmap` from the last row to the first.
%
%       Useful for assigning visually distinct colors in reverse gradient order.
%
%   Example:
%       cmap = jet(256);
%       coloridx = fullcmap(cmap, 10);
%       selectedColors = cmap(coloridx, :);
%
%   See also: LINSPACE, COLORMAP, PATCH, UPPATCHCMAP

function coloridx = fullcmap(cmap,nobjs)
    coloridx = round(linspace(size(cmap, 1), 1, nobjs)); 
end