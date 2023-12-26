function map=electodeArrayMap(featureVector)

for i=1:8
    for j=1:8
        map(i,j)=featureVector(64-(i-1)*8-(j-1));
    end
end