function SM=mySM(sig,fs,order)

[pxx,f] = pwelch(sig,floor(fs/2),[],[],fs);

SM=sum(pxx.*(f.^order));