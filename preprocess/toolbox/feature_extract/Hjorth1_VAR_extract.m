function VAR_feature=Hjorth1_VAR_extract(EMG)

Nchannel=size(EMG,1);

VAR_feature=zeros(1,Nchannel);

for i=1:Nchannel
    VAR_feature(i)=var(EMG(i,:));
end