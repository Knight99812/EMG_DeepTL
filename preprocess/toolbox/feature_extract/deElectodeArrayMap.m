function featureVector=deElectodeArrayMap(map)

for i=1:8
    for j=1:8
        featureVector(64-(i-1)*8-(j-1))=map(i,j);
    end
end