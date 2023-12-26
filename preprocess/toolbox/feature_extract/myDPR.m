function DPR=myDPR(sig,fs)

[pxx,f] = pwelch(sig,floor(fs/2),[],[],fs);

for i=1:length(f)
    pxx_smooth(i)=mean(pxx(max(1,i-6):min(i+6,length(f))));% using 6*2+1=13 consecutive points
end

[~,f_idx1]=min(abs(f-35));
[~,f_idx2]=min(abs(f-600));

if(min(pxx(f_idx1:f_idx2))~=0)
    DPR=max(pxx(f_idx1:f_idx2))/min(pxx(f_idx1:f_idx2));
else
    DPR=1;
end