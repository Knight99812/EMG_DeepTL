function RMSfeature=RMSextract(data)

for i=1:length(data)
    tmp=data{1,i};
    for j=1:size(tmp,2)
        sig=tmp(:,j);
        RMSfeature(i,j)=myRMS(sig);
    end
end