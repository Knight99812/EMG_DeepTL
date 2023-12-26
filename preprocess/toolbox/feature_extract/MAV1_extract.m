function MAV1_feature=MAV1_extract(EMG)

Nchannel=size(EMG,1);

MAV1_feature=zeros(1,Nchannel);

for i=1:Nchannel
    MAV1_feature(i)=myMAV1(EMG(i,:));
end