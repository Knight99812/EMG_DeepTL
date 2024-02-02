function MNP=myMNP(sig,fs)

[pxx,f] = pwelch(sig,floor(fs/2),[],[],fs);
MNP=mean(pxx);