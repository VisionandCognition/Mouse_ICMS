function [psth_time, psth_bin, psth_fig] = psth(trl_time,event_matrix, bin_size)
%CALCULATE AND PLOT THE PERI-STIMULUS TIME HISTOGRAM (PSTH) OF AN EVENT MATRIX
%
%   Input: trl_time -- original trial time in seconds;
%          event_matrix -- event matrix in trl-by-time
%          bin_size -- in seconds
%  Output: psth_time -- time axis (in s) for the PSTH
%          psth_bin -- firing rate (FR, in Hz) of each bin
%          psth_fig -- graphic handle of the PSTH figure
%
% created by B. Li on 2021.04.16


% determine sampling interval
sp_interval = trl_time(2)-trl_time(1); % must in unit of seconds

% determine how many samples per bin
sp_perBin = ceil(bin_size/sp_interval); % round up if not a whole number

% build the time axis for psth
psth_time = trl_time(1,sp_perBin:sp_perBin:size(event_matrix,2));

% re-shape the event matrix according to the new bin size
event_matrix_new = zeros(size(event_matrix,1),size(psth_time,2));
for i = 1:size(event_matrix_new,2)
    event_matrix_new(:,i) = sum(event_matrix(:,((i-1)*sp_perBin+1):(i*sp_perBin)),2);
end

% calculate the psth array
psth_bin = mean(event_matrix_new,1)/bin_size;

% plot psth
psth_fig = figure;
bar(psth_time,psth_bin);
xlabel('Time (s)');
ylabel('FR (Hz)');

end

