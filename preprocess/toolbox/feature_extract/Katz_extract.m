function Katz_feature=Katz_extract(EMG)

Nchannel=size(EMG,1);

Katz_feature=zeros(1,Nchannel);

for i=1:Nchannel
    Katz_feature(i)=Katz_FD(EMG(i,:));
end