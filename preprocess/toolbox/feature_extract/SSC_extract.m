function SSC_feature=SSC_extract(EMG,EMG_Rest,thresh_SSC)

Nchannel=size(EMG,1);

SSC_feature=zeros(1,Nchannel);

for i=1:Nchannel
    thresh=thresh_SSC*myRMS(EMG_Rest(i,:));
    SSC_feature(i)=mySSC(EMG(i,:),thresh);
end