function RMSmap_all=vector2map(RMSvector)

for i=1:4 % 4 electrode arrays
    vector_tmp=RMSvector((i-1)*64+1:i*64);
    for j=1:64
        rowIdx=floor((j-1)/8)+1;
        columnIdx=9-(j-(rowIdx-1)*8);
        RMSmap_all(rowIdx,columnIdx,i)=vector_tmp(j);
    end
end

