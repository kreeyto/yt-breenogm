% GENARRAY  Generates a structured array for associating sound frames and audio files.
%
%   sdata = genArray(nsounds, nmsounds, sdarray, panarray)
%
%   Inputs:
%       nsounds   - Number of sound objects (e.g. balls)
%       nmsounds  - Base path and name prefix for sound files (e.g. 'media/sound')
%       sdarray   - Cell array of frame indices (moments when sound should play)
%       panarray  - Cell array of stereo pan values for each object
%
%   Output:
%       sdata     - A cell array of size (nsounds x 3), where each row contains:
%                      {1} → array of frame indices (trigger times)
%                      {2} → list of corresponding .wav filenames
%                      {3} → stereo pan setting (-1 to 1)
%
%   Description:
%       This function builds a structured cell array used to generate composite
%       audio tracks for the animation. Each sound object is linked to:
%         - A set of frame triggers (from sdarray)
%         - One or more corresponding .wav files (loaded by name pattern)
%         - A pan value to position the sound in stereo space
%
%       If the total number of `.wav` files exceeds `nsounds`, the function assumes
%       that there are multiple .wav files per object, and distributes them accordingly.
%
%   Example:
%       sdata = genArray(56, 'media/pwave', somArray, panValues);
%
%   See also: GENAUDIO, AUDIOWRITE, DIR, SPRINTF

function sdata = genArray(nsounds, nmsounds, sdarray, panarray)
    sdata = cell(nsounds, 3);
    ttfiles = length(dir([char(nmsounds) '*.wav']));
    if ttfiles > nsounds
        for i = 1:nsounds
            sdata{i, 1} = sdarray{i};
            sdfiles = cell(1, ttfiles/nsounds);
            for j = 1:length(sdfiles)
                fileidx = (j-1)*nsounds + i; 
                sdfiles{j} = sprintf('%s%02d.wav', nmsounds, fileidx);
            end
            sdata{i, 2} = sdfiles;
            sdata{i, 3} = panarray{i};
        end
    else
        for i = 1:nsounds
            sdata{i, 1} = sdarray{i};
            sdata{i, 2} = sprintf('%s%02d.wav', nmsounds, i);
            sdata{i, 3} = panarray{i};
        end
    end
end
