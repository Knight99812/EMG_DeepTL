function MFL_feature=MFL_extract(EMG)

Nchannel=size(EMG,1);

MFL_feature=zeros(1,Nchannel);

for i=1:Nchannel
    MFL_feature(i)=myMFL(EMG(i,:));
end