function ZC_feature=ZC_extract(EMG,EMG_Rest,thresh_ZC)

Nchannel=size(EMG,1);

ZC_feature=zeros(1,Nchannel);

for i=1:Nchannel
    thresh=thresh_ZC*myRMS(EMG_Rest(i,:));
    ZC_feature(i)=myZC(EMG(i,:),thresh);
end