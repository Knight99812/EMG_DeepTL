function V_feature=V_extract(EMG,order)

Nchannel=size(EMG,1);

V_feature=zeros(1,Nchannel);

for i=1:Nchannel
    V_feature(i)=myV(EMG(i,:),order);
end