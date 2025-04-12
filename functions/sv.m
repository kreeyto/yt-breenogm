% SV  Sets up and opens a VideoWriter object for saving animation frames.
%
%   obj = sv(title)
%
%   Input:
%       title - Name of the video file (without extension)
%
%   Output:
%       obj   - An opened VideoWriter object ready to receive frames
%
%   Description:
%       This function initializes a `VideoWriter` object using the Motion JPEG AVI
%       format with:
%         - Quality = 100 (maximum)
%         - FrameRate = 60 FPS (default for animation sync)
%
%       The output file is saved in the directory:
%           D:\Videos\{title}.avi
%
%       The object is opened immediately for writing.
%
%   Notes:
%       - Ensure the directory `D:\Videos\` exists before running.
%       - To write frames, use `writeVideo(obj, frame)`.
%       - Don’t forget to call `close(obj)` after writing (or use `cv.m`).
%
%   See also: VIDEOWRITER, GF, CV, WRITEVIDEO

function obj = sv(title)
    obj = VideoWriter(strcat('D:\Videos\', title), 'Motion JPEG AVI'); 
    obj.Quality = 100;
    obj.FrameRate = 60;
    open(obj); 
end
