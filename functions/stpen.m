% STPEN  Computes a wrapped index based on a stepping pattern.
%
%   idx = stpen(f, ind, tamsim)
%
%   Inputs:
%       f       - Step factor or frequency multiplier
%       ind     - Current index or loop iteration
%       tamsim  - Total size of the simulation (used for wrapping)
%
%   Output:
%       idx     - Wrapped index (1-based), guaranteed to be in 1:tamsim
%
%   Description:
%       This function calculates an index by multiplying the iteration number
%       by a frequency factor (`f`), then wraps the result within the range
%       [1, tamsim] using modulo arithmetic. If the result is 0 (i.e. divisible),
%       it is replaced by `tamsim` to ensure indexing stays valid (MATLAB is 1-based).
%
%   Use case:
%       Useful for periodic access of arrays or visual triggers in animations.
%
%   See also: MOD, FLOOR, CEIL

function idx = stpen(f,ind,tamsim)
    idx = mod(f*ind, tamsim);
    if idx == 0
        idx = tamsim;
    end
end
        