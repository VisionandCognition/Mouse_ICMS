file_loc = '\\vs02\vandc\ICMS\MANTA\B-LY14\Ephys\Geordi_20210420\Geordi_20210420Block-1\Geordi_20210420Block-1.mua.hdf5';
trl.time_pre = 1;
trl.time_post = 2;
trl.sn_pre = trl.time_pre*t.fs;
trl.sn_post = trl.time_post*t.fs;
trl.sn_length = ceil((trl.time_pre + trl.time_post)*t.fs);
t.trl = t.sampling_interval:t.sampling_interval:(trl.sn_length*t.sampling_interval);
t.trl = t.trl - trl.time_pre;

elec.total = 11;
elec.list = 0:1:elec.total-1;

spk.mua.raw = cell(1,elec.total);
for i = 1:elec.total
    spk.mua.raw{i} = h5read(file_loc, ['/spiketimes/elec_' num2str(elec.list(i))]);
end

% Work on the sn for each trial
trl.sn_start = stim.sn - trl.sn_pre;


spk.mua.trl = cell(1,elec.total);
stim.total = size(stim.sn, 2);


for e = 1:elec.total
    spk.mua.trl{e} = zeros(stim.total, trl.sn_length);
    for tln = 1:stim.total
        tmp.spkloc = spk.mua.raw{e}>=trl.sn_start(tln) & spk.mua.raw{e}<=(trl.sn_start(tln)+trl.sn_length);
        tmp.spkidx = spk.mua.raw{e}(tmp.spkloc);
        if ~isempty(tmp.spkidx)
            tmp.spkidx_rel_onset = tmp.spkidx - trl.sn_start(tln);
            spk.mua.trl{e}(tln,tmp.spkidx_rel_onset) = 1;
        end
        clear tmp
    end
end

save([fn.tank fn.block '_MUA' '.mat'], 'trl', 't', 'elec', 'spk', 'fn', 'stim');
