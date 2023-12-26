function VCF=myVCF(sig,fs)

SM0=mySM(sig,fs,0);
SM1=mySM(sig,fs,1);
SM2=mySM(sig,fs,2);

VCF=SM2/SM0-(SM1/SM0)^2;