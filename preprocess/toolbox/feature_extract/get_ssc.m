function ssc=get_ssc(emg,window_len,step_len,thresh, fs)
% emg: EMG data (a Nsample x Nchannel matrix)
% window_len: length of sliding time window (in second) to extract features
% step_len: step length the time window moves each time (in second)
% thresh: the threshold to detect valid slope sign changes
% fs: sampling rate
% ssc: extracted slope sign change features

window_sample=floor(window_len*fs);
step_sample=floor(step_len*fs);
[Nsample,Nchannel]=size(emg);

fea_idx=0;
for i=1:step_sample:(Nsample-window_sample+1)
    fea_idx=fea_idx+1;
    for j=1:Nchannel
        emg_window=emg(i:i+window_sample-1,j);
        ssc(fea_idx,j)=my_ssc(emg_window,thresh);
    end
end