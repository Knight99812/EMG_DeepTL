function VCF_feature=VCF_extract(EMG,fs)

Nchannel=size(EMG,1);

VCF_feature=zeros(1,Nchannel);

for i=1:Nchannel
    VCF_feature(i)=myVCF(EMG(i,:),fs);
end