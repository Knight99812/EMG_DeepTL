function HG_feature=HG_extract(EMG,kmax)

Nchannel=size(EMG,1);

HG_feature=zeros(1,Nchannel);

for i=1:Nchannel
    HG_feature(i)=myHG(EMG(i,:),kmax);
end