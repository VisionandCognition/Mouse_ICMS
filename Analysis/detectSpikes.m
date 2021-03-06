function [s] = detectSpikes(x, Fs, threshold)
% Detect spikes.
%   [s, t] = detectSpikes(x, Fs) detects spikes in x, where Fs the sampling
%   rate (in Hz). The outputs s and t are column vectors of spike times in
%   samples and ms, respectively. By convention the time of the zeroth
%   sample is 0 ms.

% detect local minima where at least one channel is above threshold
% threshold = -4;
noiseSD = median(abs(x)) / 0.6745;      % robust estimate of noise SD
z = bsxfun(@rdivide, x, noiseSD);
mz = min(z, [], 2);
r = sqrt(sum(x .^ 2, 2));               % take norm for finding extrema
dr = diff(r);
s = find(mz(2 : end - 1) < threshold & dr(1 : end - 1) > 0 & dr(2 : end) < 0) + 1;
s = s(s > 10 & s < size(x, 1) - 25);    % remove spikes close to boundaries

% if multiple spikes occur within 0.5 ms we keep only the largest
refractory = 0.5 / 1000 * Fs;
N = numel(s);
keep = true(N, 1);
last = 1;
for i = 2 : N
    if s(i) - s(last) < refractory
        if r(s(i)) > r(s(last))
            keep(last) = false;
            last = i;
        else
            keep(i) = false;
        end
    else
        last = i;
    end
end
s = s(keep);
% t = s / Fs * 1000;                      % convert to real times in ms
end