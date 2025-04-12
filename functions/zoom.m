% ZOOM  Generates a stereo frequency sweep with dynamic panning.
%
%   zoom(sfreq, efreq, sz, name, pan1, pan2, pan3, pan4, pan5, pan6, pan7, pan8)
%
%   Inputs:
%       sfreq   - Start frequency of the sweep (Hz)
%       efreq   - End frequency of the sweep (Hz)
%       sz      - Duration of the sound (seconds)
%       name    - Output .wav file name (string)
%       pan1–8  - Panning values (-1 = left, +1 = right) for each of the 4 segments
%
%   Description:
%       This function creates a logarithmic-like linear frequency sweep from `sfreq` to
%       `efreq` over a duration `sz`. The sweep is rendered in stereo with panning that
%       evolves across four defined segments using the eight `pan` values.
%
%       The output signal:
%         - Is normalized to a max volume scaled by `volcrt = 0.1`
%         - Uses square-root stereo panning:
%               Left  = (1 - pan)/2
%               Right = (1 + pan)/2
%
%       Panning is applied in 4 segments:
%         1. pan1 → pan2
%         2. pan3 → pan4
%         3. pan5 → pan6
%         4. pan7 → pan8
%
%       The final audio is saved to disk using `audiowrite`.
%
%   Output:
%       - A stereo `.wav` file saved as `name`
%
%   See also: AUDIOWRITE, SIN, LINSPACE

function zoom(sfreq, efreq, sz, name, pan1, pan2, ...
    pan3, pan4, pan5, pan6, pan7, pan8)
    fs = 44100; 
    t = 0:1/fs:sz;
    k = (efreq - sfreq)/sz;
    fqswp = sfreq + k/2*t;
    ausign = sin(2*pi*fqswp.*t);
    ausign = ausign / max(abs(ausign));
    volcrt = 0.1; 
    ausign = volcrt * ausign;
    pan = [linspace(pan1, pan2, floor(length(t)/4)), ...
        linspace(pan3, pan4, floor(length(t)/4)), ...
        linspace(pan5, pan6, floor(length(t)/4)), ...
        linspace(pan7, pan8, length(t)-3*floor(length(t)/4))];
    pan = pan(1:length(t)); 
    left = ausign.*(0.5-pan/2);
    right = ausign.*(0.5+pan/2);
    ausign = [left; right]';
    audiowrite(name, ausign, fs);
end
