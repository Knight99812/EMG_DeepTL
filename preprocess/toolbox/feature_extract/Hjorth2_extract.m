function Hjorth2_feature=Hjorth2_extract(EMG)

Nchannel=size(EMG,1);

Hjorth2_feature=zeros(1,Nchannel);

for i=1:Nchannel
    Hjorth2_feature(i)=myHjorth2(EMG(i,:));
end