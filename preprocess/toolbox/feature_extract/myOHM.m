function OHM=myOHM(sig,fs)

SM0=mySM(sig,fs,0);
SM1=mySM(sig,fs,1);
SM2=mySM(sig,fs,2);

OHM=(sqrt(SM2/SM1))/(SM1/SM0);