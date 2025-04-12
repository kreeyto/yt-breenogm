% CV  Closes a VideoWriter object.
%
%   cv(v)
%
%   Inputs:
%       v - A valid VideoWriter object
%
%   Description:
%       This function is a simple wrapper around the built-in `close`
%       function, specifically for finalizing and closing a video file
%       after frames have been written.
%
%   See also: VIDEOREADER, VIDEOWRITER, OPEN, GF

function cv(v)
    close(v);
end
