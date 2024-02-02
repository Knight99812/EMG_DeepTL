function SKW_feature=SKW_extract(EMG)

Nchannel=size(EMG,1);

SKW_feature=zeros(1,Nchannel);

for i=1:Nchannel
    SKW_feature(i)=mySKW(EMG(i,:));
end