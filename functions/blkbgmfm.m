% BLKBGMFM  Fades color or transparency of a graphical object over a fixed number of frames.
%
%   blkbgmfm(myobj, nframes, swcolor, bgcolor, period)
%
%   This function gradually transitions the color or alpha value of a graphical
%   object (`myobj`) over `nframes` frames using a MATLAB timer. It is a
%   simplified version of `blkbgm` with only mode and frame control.
%
%   Inputs:
%       myobj    - Handle to the patch or surface object
%       nframes  - Number of transition frames (tasks to execute)
%       swcolor  - 's' to use color transition, otherwise use alpha fading
%       bgcolor  - Target RGB color for transition (in 0–255 format)
%       period   - Time (in seconds) between frames
%
%   Description:
%       A timer is created to animate a smooth visual effect. If `swcolor == 's'`,
%       the object's color blends from `bgcolor` back to its original color.
%       If not, the function performs a cosine interpolation on the alpha channel.
%
%       The object restores its original appearance once the transition completes.
%
%   Notes:
%       - Replaces any existing animation timer on the object.
%       - Color blending assumes RGB triplet in range [0, 255].
%
%   See also: BLKBGM, TIMER, PATCH

function blkbgmfm(myobj, nframes, swcolor, bgcolor, period)
    if isfield(myobj.UserData, 'blktimer') && isvalid(myobj.UserData.blktimer)
        stop(myobj.UserData.blktimer);
        delete(myobj.UserData.blktimer);
    end
    myobj.UserData.originalColor = get(myobj, 'FaceColor');
    myobj.UserData.originalFaceAlpha = get(myobj, 'FaceAlpha'); 
    blktimer = timer('ExecutionMode', 'fixedRate', 'Period', period, 'TasksToExecute', nframes);
    blktimer.TimerFcn = @(newtimer, ~) blkCallback(newtimer, myobj, swcolor, bgcolor);
    myobj.UserData.blktimer = blktimer;
    start(blktimer);
end

function blkCallback(newtimer, myobj, swcolor, bgcolor)
    if isvalid(myobj)
        t = (newtimer.TasksExecuted-1) / (newtimer.TasksToExecute-1);
        if strcmp(swcolor, 's')
            color = bgcolor/255 * (1-t) + myobj.UserData.originalColor * t; 
            set(myobj, 'FaceColor', color);
        else
            alpha = myobj.UserData.originalFaceAlpha * (0.5 - 0.5 * cos(pi * t));
            set(myobj, 'FaceAlpha', alpha);
        end
        if newtimer.TasksExecuted == newtimer.TasksToExecute
            stop(newtimer);
            delete(newtimer);
            myobj.UserData = rmfield(myobj.UserData, 'blktimer');
        end
    else
        stop(newtimer);
        delete(newtimer);
    end
end
