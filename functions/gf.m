% GF  Captures and writes a frame to a video file.
%
%   gf(v, fig)
%
%   Inputs:
%       v   - VideoWriter object (opened with `open`)
%       fig - Handle to the figure to capture (usually `gcf`)
%
%   Description:
%       This function captures the current state of the specified figure
%       using `getframe` and immediately writes it to the open video object.
%       It is typically used inside animation loops to export each frame.
%
%   See also: GETFRAME, WRITEVIDEO, SV, CV

function gf(v,fig)
    frame = getframe(fig);
    writeVideo(v, frame); 
end