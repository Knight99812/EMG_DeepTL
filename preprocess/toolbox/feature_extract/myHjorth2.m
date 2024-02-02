function Hjorth2feature=myHjorth2(sig)

sig_diff1=diff(sig);
Hjorth2feature=std(sig_diff1)/std(sig);