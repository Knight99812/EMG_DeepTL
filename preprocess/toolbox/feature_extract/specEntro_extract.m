function specEntro_feature=specEntro_extract(EMG,fs)

Nchannel=size(EMG,1);

specEntro_feature=zeros(1,Nchannel);

for i=1:Nchannel
    
    specEntro_feature(i)=pentropy(EMG(i,:)',fs,'Instantaneous',false);
end