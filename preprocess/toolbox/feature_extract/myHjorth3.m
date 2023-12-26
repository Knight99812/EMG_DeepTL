function Hjorth3feature=myHjorth3(sig)

sig_diff1=diff(sig);
sig_diff2=diff(sig_diff1);
Hjorth3feature=(std(sig_diff2)/std(sig_diff1)) / (std(sig_diff1)/std(sig));