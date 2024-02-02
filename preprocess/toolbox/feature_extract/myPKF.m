function PKF=myPKF(sig,fs)

[pxx,f] = pwelch(sig,floor(fs/2),[],[],fs);

[value,idx]=max(pxx);

PKF=f(idx);