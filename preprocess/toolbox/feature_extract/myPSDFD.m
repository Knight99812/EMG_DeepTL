function PSDFD=myPSDFD(sig,fs)

[pxx,f] = pwelch(sig,floor(fs/2),[],[],fs);
Xpred = [ones(length(f(2:end)),1) log10(f(2:end))];
b = lscov(Xpred,log10(pxx(2:end)));
PSDFD=(5-(-b(2)))/2;