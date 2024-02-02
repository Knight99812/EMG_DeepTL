function PSDFD_feature=PSDFD_extract(EMG,fs)

Nchannel=size(EMG,1);

PSDFD_feature=zeros(1,Nchannel);

for i=1:Nchannel
    PSDFD_feature(i)=myPSDFD(EMG(i,:),fs);
end