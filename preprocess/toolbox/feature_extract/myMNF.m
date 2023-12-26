function MNF=myMNF(sig,fs)

[pxx,f] = pwelch(sig,floor(fs/2),[],[],fs);
MNF=(sum(f.*pxx)) / (sum(pxx));