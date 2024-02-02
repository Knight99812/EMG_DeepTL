function RMSValue=myRMS(sig)

sig_square=sig.^2;
RMSValue=sqrt(mean(sig_square));