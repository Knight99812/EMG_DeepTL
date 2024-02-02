function rms_value=my_rms(sig)

sig_square=sig.^2;
rms_value=sqrt(mean(sig_square));