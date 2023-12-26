function WL_feature=WL_extract(EMG)

Nchannel=size(EMG,1);

WL_feature=zeros(1,Nchannel);

for i=1:Nchannel
    WL_feature(i)=myWL(EMG(i,:));
end