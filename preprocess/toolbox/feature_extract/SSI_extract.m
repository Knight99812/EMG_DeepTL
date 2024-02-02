function SSI_feature=SSI_extract(EMG)

Nchannel=size(EMG,1);

SSI_feature=zeros(1,Nchannel);

for i=1:Nchannel
    SSI_feature(i)=mySSI(EMG(i,:));
end