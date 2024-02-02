function IAV_feature=IAV_extract(EMG)

Nchannel=size(EMG,1);

IAV_feature=zeros(1,Nchannel);

for i=1:Nchannel
    IAV_feature(i)=sum(abs(EMG(i,:)));
end