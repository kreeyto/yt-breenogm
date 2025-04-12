% ENDSEC  Appends extra seconds to the end of a video.
%
%   endsec(numaddit, obj, figure)
%
%   This function adds a specified number of seconds (in frames) to the end
%   of a video by repeatedly writing the current frame of the figure.
%
%   Inputs:
%       numaddit - Number of seconds to add
%       obj      - VideoWriter object currently in use
%       figure   - Handle to the figure to capture
%
%   Description:
%       Useful for allowing the animation to "linger" at the end,
%       so that viewers can absorb the final scene. Assumes a frame
%       rate of 60 FPS for frame count calculation.
%
%   See also: WRITEVIDEO, GETFRAME, SV, CV

function endsec(numaddit, obj, figure) 
    numsec = numaddit * 60;
    for k = 1:numsec
        writeVideo(obj, getframe(figure));
    end
end