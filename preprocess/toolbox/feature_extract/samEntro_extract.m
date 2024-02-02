function samEntro_feature=samEntro_extract(EMG)

m=2;
r=0.2;

Nchannel=size(EMG,1);

samEntro_feature=zeros(1,Nchannel);

for i=1:Nchannel

    samEntro_feature(i)=sampen(EMG(i,:), m, r);
end