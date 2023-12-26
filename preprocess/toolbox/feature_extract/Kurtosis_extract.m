function Kurtosis_feature=Kurtosis_extract(EMG)

Nchannel=size(EMG,1);

Kurtosis_feature=zeros(1,Nchannel);

for i=1:Nchannel
    Kurtosis_feature(i)=kurtosis(EMG(i,:));
end