function FR=myFR(sig,fs,fl,fh)

[pxx,f] = pwelch(sig,floor(fs/2),[],[],fs);

[~,fl_idx1]=min(abs(f-fl(1)));
[~,fl_idx2]=min(abs(f-fl(2)));
[~,fh_idx1]=min(abs(f-fh(1)));
[~,fh_idx2]=min(abs(f-fh(2)));

FR=sum(pxx(fl_idx1:fl_idx2))/sum(pxx(fh_idx1:fh_idx2));