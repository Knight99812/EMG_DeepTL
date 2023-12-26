function MYOP_feature=MYOP_extract(EMG,thresh_MYOP)

Nchannel=size(EMG,1);

MYOP_feature=zeros(1,Nchannel);

for i=1:Nchannel
    MYOP_feature(i)=myMYOP(EMG(i,:),thresh_MYOP);
end