function MAV2_feature=MAV2_extract(EMG)

Nchannel=size(EMG,1);

MAV2_feature=zeros(1,Nchannel);

for i=1:Nchannel
    MAV2_feature(i)=myMAV2(EMG(i,:));
end