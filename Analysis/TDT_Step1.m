fn.tank = input('Enter tank name: ','s');
fn.block = input('Enter block ID: ','s');
data = TDTbin2mat([fn.tank '\' fn.block]);

% Extract RAW data
data_raw = data.streams.dRAW.data;

% Reconstruct time
t.fs = data.streams.dRAW.fs;
t.sampling_interval = 1/t.fs;
t.overall = 0:t.sampling_interval:(t.sampling_interval*(size(data_raw,2)-1));

% Load stim time
stim.t = data.scalars.Stim.ts; % stim time in second
stim.sn = stim.t * t.fs; % stim time in sample number
rep_begin_time{1} = stim.sn; % define trial start for Spyking-circus
rep_end_time{1} = stim.sn + 0.2*t.fs; % define trial end for Spyking-circus

% Write binary
fid = fopen([fn.tank fn.block '.extension'], 'w'); 
fwrite(fid, data_raw, 'int16');
fclose(fid);

% Save trial info for Spyking-circus visualization
save([fn.tank fn.block '.stim'], 'rep_begin_time', 'rep_end_time');

% Save all parameters for further processing
save([fn.tank fn.block '_par' '.mat'], 'fn', 't', 'stim');


