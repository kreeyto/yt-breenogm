% REVBLKBGM  Applies a reverse background transition to a graphical object.
%
%   revblkbgm(myobj, frate, swcolor, bgcolor)
%
%   Inputs:
%       myobj    - Handle to the graphical object (e.g. patch)
%       frate    - Number of frames for the transition (steps)
%       swcolor  - 's' for color transition, otherwise fades alpha
%       bgcolor  - RGB triplet for the background reference (0–255 scale)
%
%   Description:
%       This function animates a visual reversal of a previous fade or color blend
%       on a graphical object. It restores the object’s original color or opacity
%       gradually over `frate` steps using a MATLAB timer.
%
%       Behavior:
%         - If `swcolor == 's'`: color blends from original → bgcolor
%         - Else: face alpha fades using a cosine function (from opaque to semi-transparent)
%
%   Notes:
%       - Uses a fixed timer period of 0.25 seconds per frame
%       - Cancels any previously running timer on the object before starting
%       - Final state resets `UserData.blktimer` to avoid conflicts
%
%   See also: BLKBGM, BLKBGMFM, TIMER, PATCH

function revblkbgm(myobj, frate, swcolor, bgcolor)
    if isfield(myobj.UserData, 'blktimer') && isvalid(myobj.UserData.blktimer)
        stop(myobj.UserData.blktimer);
        delete(myobj.UserData.blktimer);
    end
    myobj.UserData.originalColor = get(myobj, 'FaceColor');
    blktimer = timer('ExecutionMode', 'fixedRate', 'Period', 0.25, 'TasksToExecute', frate);
    blktimer.TimerFcn = @(newtimer, ~) revblkCallback(newtimer, myobj, swcolor, bgcolor);
    myobj.UserData.blktimer = blktimer;
    start(blktimer);
end

function revblkCallback(newtimer, myobj, swcolor, bgcolor)
    if isvalid(myobj)
        t = (newtimer.TasksExecuted-1) / (newtimer.TasksToExecute-1);
        if strcmp(swcolor, 's')
            color = myobj.UserData.originalColor * (1-t) + bgcolor/255 * t; 
            set(myobj, 'FaceColor', color);
        else
            alpha = 0.5 + 0.5 * cos(pi * t);
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
