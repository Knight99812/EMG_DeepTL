function CC_feature=CC_extract(EMG,order)

Nchannel=size(EMG,1);

CC_feature=[];

for i=1:Nchannel
    AR_feature=myAR(EMG(i,:),order);
    CC_tmp=zeros(1,order);
    CC_tmp(1)=-AR_feature(1);
    for p=2:order
        tmp=0;
        for j=1:p-1
            tmp=tmp+(1-j/p)*AR_feature(p)*CC_tmp(p-j);
        end
        CC_tmp(p)=-AR_feature(p)-tmp;
    end
    CC_feature=[CC_feature,CC_tmp];
end