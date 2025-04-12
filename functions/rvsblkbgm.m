% RVSBLKBGM  Applies a customizable reverse transition effect to a graphical object.
%
%   rvsblkbgm(myobj, tasks, period, swcolor, bgcolor)
%
%   Inputs:
%       myobj    - Handle to the graphical object (e.g., patch or surface)
%       tasks    - Total number of timer steps (frames)
%       period   - Delay (in seconds) between each frame
%       swcolor  - 's' for smooth color interpolation; otherwise alpha fade
%       bgcolor  - RGB triplet for background reference color (0–255 scale)
%
%   Description:
%       This function performs a visual reversal on `myobj` by gradually
%       restoring its original color or transparency over a specified number
%       of steps (`tasks`). It offers full timing control through `period`.
%
%       Modes:
%         - If `swcolor == 's'`: Interpolates FaceColor from original → bgcolor
%         - Otherwise: Cosine-based fade of FaceAlpha from 1 → 0
%
%   Notes:
%       - Stores original color in `myobj.UserData.originalColor`
%       - Replaces any existing timer associated with the object
%       - Finalizes by deleting the timer and cleaning up metadata
%
%   See also: REVBLKBGM, BLKBGM, BLKBGMFM, TIMER

function rvsblkbgm(myobj, tasks, period, swcolor, bgcolor)
    if isfield(myobj.UserData, 'blktimer') && isvalid(myobj.UserData.blktimer)
        stop(myobj.UserData.blktimer);
        delete(myobj.UserData.blktimer);
    end
    myobj.UserData.originalColor = get(myobj, 'FaceColor');
    blktimer = timer('ExecutionMode', 'fixedRate', 'Period', period, 'TasksToExecute', tasks);
    blktimer.TimerFcn = @(newtimer, ~) rvsblkCallback(newtimer, myobj, swcolor, bgcolor);
    myobj.UserData.blktimer = blktimer;
    start(blktimer);
end

function rvsblkCallback(newtimer, myobj, swcolor, bgcolor)
    if isvalid(myobj)
        t = (newtimer.TasksExecuted-1) / (newtimer.TasksToExecute-1);
        if strcmp(swcolor, 's')
            color = bgcolor/255 * t + myobj.UserData.originalColor * (1-t); 
            set(myobj, 'FaceColor', color);
        else
            alpha = 0.5 * (1 + cos(pi * t));
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
