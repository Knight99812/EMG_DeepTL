function MAX_feature=MAX_extract(EMG,fs,order,fco)

Nchannel=size(EMG,1);

MAX_feature=zeros(1,Nchannel);

[b,a]=butter(order,fco/(fs/2));

for i=1:Nchannel
    MAX_feature(i)=myMAX(EMG(i,:),b,a);
end