function MAV_feature=MAV_extract(EMG)

Nchannel=size(EMG,1);

MAV_feature=zeros(1,Nchannel);

for i=1:Nchannel
    MAV_feature(i)=mean(abs(EMG(i,:)));
end