function SMR=mySMR(sig,fs)

[pxx,f] = pwelch(sig,floor(fs/2),[],[],fs);

for i=1:length(f)
    pxx_smooth(i)=mean(pxx(max(1,i-6):min(i+6,length(f))));% using 13 consecutive points
end

[~,f_idx1]=min(abs(f-35));
[~,f_idx2]=min(abs(f-600));

[~,f_idx_max]=max(pxx_smooth(f_idx1:f_idx2));
f_idx_max=f_idx_max+f_idx1-1;

x=f(1:f_idx_max);
y=0:pxx_smooth(f_idx_max)/(length(x)-1):pxx_smooth(f_idx_max);

if(length(y)>0)
    mr_energy=pxx(1:f_idx_max)-y';
    mr_energy=sum(mr_energy.*(double(mr_energy>0)));

    SMR=sum(pxx(1:f_idx2))/mr_energy;
else
    SMR=1;
end