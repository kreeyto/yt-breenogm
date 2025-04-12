% GENAUDIOMULTI  Generates stereo audio with multiple sound samples per object.
%
%   genAudioMulti(sdata, path, frate, addtstart, addtend)
%
%   Inputs:
%       sdata      - Output from genArray: a cell array where each row contains:
%                      {1} → array of frame indices (trigger times)
%                      {2} → cell array of .wav filenames (or single string)
%                      {3} → array of pan values (-1 to +1)
%       path       - Output directory (string) to save composite .wav files
%       frate      - Frame rate of the animation (e.g. 60)
%       addtstart  - Seconds of silence to prepend at the beginning
%       addtend    - Seconds of silence to append at the end
%
%   Description:
%       This function creates individual stereo audio tracks for each animated
%       object (e.g., a ball), mixing in multiple sound files triggered at
%       specific animation frames. Unlike `genAudio`, this version supports
%       varying the sound sample per event (frame).
%
%       Stereo panning is applied using square-root panning based on the
%       provided `panvel` array. If the number of sound files is fewer than the
%       number of triggers, the last file is reused.
%
%       Each sound is blended into the silent track at the correct position
%       in time, and saved as `compositeN.wav` in the given path.
%
%   Notes:
%       - Frame-to-time conversion is performed using the frame rate.
%       - If `sdata{i,2}` is a single string, it is wrapped into a cell array.
%
%   Output:
%       Composite stereo `.wav` files: path/composite1.wav, path/composite2.wav, ...
%
%   See also: GENAUDIO, AUDIOWRITE, AUDIOREAD

function genAudioMulti(sdata, path, frate, addtstart, addtend)
    ttend = max(cellfun(@max, sdata(:, 1)));
    fstsfile = sdata{1, 2};
    if iscell(fstsfile)
        fstsfile = fstsfile{1};
    end
    [~, Fs] = audioread(fstsfile);
    for i = 1:size(sdata, 1)
        sfiles = sdata{i, 2};
        if ~iscell(sfiles)
            sfiles = {sfiles};
        end
        silent = zeros(round((ttend / frate + addtstart + addtend) * Fs), 2);
        panvel = zeros(1, ttend);
        panvel(1:length(sdata{i, 3})) = sdata{i, 3};
        for j = 1:length(sdata{i, 1})
            sframe = sdata{i, 1}(j);
            sfileidx = min(j, length(sfiles));
            [y, Fs] = audioread(sfiles{sfileidx});
            soundsz = length(y);
            if length(panvel) < soundsz
                panvel(end+1:soundsz) = 0;
            end
            stsample = round((sframe / frate + addtstart) * Fs);
            edsample = min(stsample+length(y)-1, length(silent));
            for k = stsample:edsample
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
