function AAC_feature=AAC_extract(EMG)

Nchannel=size(EMG,1);

AAC_feature=zeros(1,Nchannel);

for i=1:Nchannel
    AAC_feature(i)=myAAC(EMG(i,:));
end