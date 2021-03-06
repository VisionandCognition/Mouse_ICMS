fn.tank = input('Enter tank name: ','s');
fn.block = input('Enter block ID: ','s');
data = TDTbin2mat([fn.tank '\' fn.block]);

stream2analyze = input('Enter the stream to be analyzed =','s');
temp_stream_strpath = ['data.streams.' stream2analyze];
% Reconstruct time
sampling_interval = 1/eval([temp_stream_strpath '.fs']);
t_overall = 0:sampling_interval:(sampling_interval*(size(eval([temp_stream_strpath '.data']),2)-1));


% BP filter
data_BpFilt = TDTdigitalfilter(data, stream2analyze, [300, 3000]); % look at 300-3000 Hz only
data_Bpfilt = data_BpFilt.streams.dRAW.data;

% Plot ch data
plot(t_overall,eval([temp_stream_strpath '.data(3,:)']));

subplot(4,1,1);
plot(t_overall,data_Bpfilt(1,:));
xlim([130349 135348]);
subplot(4,1,2);
plot(t_overall,data_Bpfilt(5,:));
xlim([130349 135348]);
subplot(4,1,3);
plot(t_overall,data_Bpfilt(7,:));
xlim([130349 135348]);
subplot(4,1,4);
plot(t_overall,data_Bpfilt(11,:));
xlim([130349 135348]);

for i = 1:3
    subplot(3,1,i);
    plot(t_overall,data_Bpfilt(i,:));
    xlim([17.515 17.715]);
    %ylim([-2000 2000]);
end


fid = fopen('KiloSort_Output.bin', 'w'); 
fwrite(fid, data.streams.dRAW.data, 'int16');
fclose(fid);

save('MANTA_11ch_TDT.mat', ...
    'chanMap','connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')