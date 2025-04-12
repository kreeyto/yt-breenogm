% GENAUDIO  Generates composite stereo audio tracks from frame-based triggers.
%
%   genAudio(sdata, path, frate, addtstart, addtend)
%
%   Inputs:
%       sdata      - Output from genArray: a cell array where each row contains:
%                      {1} → frame indices (trigger times)
%                      {2} → .wav file name(s)
%                      {3} → pan values (-1 for full left, +1 for full right)
%       path       - Output directory (string) to save composite audio files
%       frate      - Frame rate used in the animation (e.g. 60)
%       addtstart  - Time in seconds to prepend as silence
%       addtend    - Time in seconds to append as silence
%
%   Description:
%       This function generates a stereo .wav file for each object/ball.
%       For each trigger frame, the corresponding .wav sample is mixed into a
%       silent track at the proper time. Pan values control left-right balance.
%
%       The stereo signal is generated using square-root panning:
%           - Left  = y * sqrt((1 - pan) / 2)
%           - Right = y * sqrt((1 + pan) / 2)
%
%       The final track includes silence before and after the animation, controlled
%       by `addtstart` and `addtend`, to allow for fade-ins or lingering visuals.
%
%   Output:
%       Composite stereo .wav files saved as:
%           path/composite1.wav, path/composite2.wav, ...
%
%   See also: AUDIOWRITE, AUDIOREAD, GENAUDIO, GEARARRAY

function genAudio(sdata, path, frate, addtstart, addtend)
    ttframes = max(cellfun(@max, sdata(:, 1)));
    for i = 1:size(sdata, 1)
        [y, Fs] = audioread(sdata{i, 2});
        silent = zeros(round((ttframes / frate + addtstart + addtend) * Fs), 2);
        panvel = zeros(1, ttframes);
        panvel(1:length(sdata{i, 3})) = sdata{i, 3};
        soundsz = length(y);
        if length(panvel) < soundsz
            panvel(end+1:soundsz) = 0;
        end
        for j = 1:length(sdata{i, 1})
            stframe = sdata{i, 1}(j);
            stsample = round((stframe / frate + addtstart) * Fs);
            endSample = min(stsample+length(y)-1, length(silent));
            for k = stsample:endSample
                tgframe = sdata{i, 1}(j);
                fsinstart = round((k - stsample) / Fs * frate);
                curframe = tgframe + fsinstart;
                panv = panvel(curframe);
                silent(k, 1) = y(k-stsample+1) * sqrt((1 - panv)/2);
                silent(k, 2) = y(k-stsample+1) * sqrt((1 + panv)/2);
            end
        end
        newpath = sprintf('%scomposite%d.wav', path, i);
        audiowrite(newpath, silent, Fs);
    end
end