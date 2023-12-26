function SNR=mySNR(sig,noise)

SNR=10*log10(mean(sig.^2)/mean(noise.^2));