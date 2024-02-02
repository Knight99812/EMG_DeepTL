function MDF=myMDF(sig,fs)

[pxx,f] = pwelch(sig,floor(fs/2),[],[],fs);
tmp=1/2*(sum(pxx));
pxx_cumsum=cumsum(pxx);
diff_pxx_cumsum=abs(pxx_cumsum-tmp);
[minV,minIdx]=min(diff_pxx_cumsum);
MDF=f(minIdx);