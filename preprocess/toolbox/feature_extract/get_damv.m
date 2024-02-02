function damv=get_damv(emg,window_len,step_len,fs)
% emg: EMG data (a Nsample x Nchannel matrix)
% window_len: length of sliding time window (in second) to extract features
% step_len: step length the time window moves each time (in second)
% fs: sampling rate
% damv: Difference Absolute Mean Value

window_sample=floor(window_len*fs);
step_sample=floor(step_len*fs);
[Nsample,Nchannel]=size(emg);

fea_idx=0;
for i=1:step_sample:(Nsample-window_sample+1)
    fea_idx=fea_idx+1;
    for j=1:Nchannel
        emg_window=emg(i:i+window_sample-1,j);
        damv(fea_idx,j)=my_damv(emg_window);
    end
end