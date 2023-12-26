function WAMP_feature=WAMP_extract(EMG,thresh_WAMP)

Nchannel=size(EMG,1);

WAMP_feature=zeros(1,Nchannel);

for i=1:Nchannel
    WAMP_feature(i)=myWAMP(EMG(i,:),thresh_WAMP);
end