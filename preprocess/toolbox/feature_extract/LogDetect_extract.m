function LogDetect_feature=LogDetect_extract(EMG)

Nchannel=size(EMG,1);

LogDetect_feature=zeros(1,Nchannel);

for i=1:Nchannel
    LogDetect_feature(i)=myLogDetect(EMG(i,:));
end