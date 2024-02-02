function VFD_feature=VFD_extract(EMG)

Nchannel=size(EMG,1);

VFD_feature=zeros(1,Nchannel);

for i=1:Nchannel
    hurst=estimate_hurst_exponent(EMG(i,:));
    VFD_feature(i)=2-hurst;
end