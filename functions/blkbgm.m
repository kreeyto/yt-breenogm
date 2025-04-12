% BLKBGM  Applies a fading background effect to a graphical object over time.
%
%   blkbgm(myobj, frate, swcolor, bgcolor, period, dropalpha)
%
%   This function animates the color or transparency of a patch or surface
%   object (`myobj`) using a timer, producing a gradual transition to a
%   background state.
%
%   Inputs:
%       myobj     - Handle to the graphic object (e.g. patch or surface)
%       frate     - Number of steps (frames) in the transition
%       swcolor   - 's' to interpolate between colors, otherwise use alpha
%       bgcolor   - Target color for the transition (RGB triplet)
%       period    - Time step (in seconds) between frames
%       dropalpha - Boolean flag to use alpha fading instead of color
%
%   Description:
%       The function creates a MATLAB timer that interpolates either the color
%       or the face alpha of `myobj` over `frate` frames. It stores and restores
%       the original appearance after the transition completes.
%
%       - If `swcolor == 's'`, it blends from `bgcolor` to the original color.
%       - Otherwise, it optionally performs a cosine fade-in on the alpha channel.
%
%   Notes:
%       - This function cancels any existing animation timer already running
%         on the object before starting a new one.
%       - Color values must be in 0–255 format.
%
%   See also: TIMER, PATCH, REVERSEBLINKEFFECT, WATERCOLOR

function blkbgm(myobj, frate, swcolor, bgcolor, period, dropalpha)
    if isfield(myobj.UserData, 'blktimer') && isvalid(myobj.UserData.blktimer)
        stop(myobj.UserData.blktimer);
        delete(myobj.UserData.blktimer);
    end
    myobj.UserData.originalColor = get(myobj, 'FaceColor');
    myobj.UserData.originalFaceAlpha = get(myobj, 'FaceAlpha'); 
    blktimer = timer('ExecutionMode', 'fixedRate', 'Period', period, 'TasksToExecute', frate);
    blktimer.TimerFcn = @(newtimer, ~) blkCallback(newtimer, myobj, swcolor, bgcolor, dropalpha);
    myobj.UserData.blktimer = blktimer;
    start(blktimer);
end

function blkCallback(newtimer, myobj, swcolor, bgcolor, dropalpha)
    if isvalid(myobj)
        t = (newtimer.TasksExecuted-1) / (newtimer.TasksToExecute-1);
        if strcmp(swcolor, 's')
            color = bgcolor/255 * (1-t) + myobj.UserData.originalColor * t; 
            set(myobj, 'FaceColor', color);
        else
            if dropalpha
                alpha = myobj.UserData.originalFaceAlpha * (0.5 - 0.5 * cos(pi * t));
                set(myobj, 'FaceAlpha', alpha);
            else
                color = bgcolor/255 * (1-t) + myobj.UserData.originalColor * t; 
                set(myobj, 'FaceColor', color);
            end
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
