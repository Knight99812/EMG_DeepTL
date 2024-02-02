function featureSmooth=myFeatureMapSmooth(feature,skip)

% batch=64; smooth each 64 features (one electrode array) separately
% layout: channel arrangement of each electrode array

featureSmooth=feature;

batch=64;

for i=1:8
    for j=1:8
        layout(i,j)=64-(i-1)*8-(j-1);
        loc1(i,j)=i;
        loc2(i,j)=j;
    end
end


for q=1:skip
for i=1:size(feature,1)
    for j=1:size(feature,2)/batch/skip
        mask=ones(size(layout));
        feature_vector=feature(i,(j-1)*batch*skip+q:skip:j*batch*skip);
        mean_val=mean(feature_vector);
        std_val=std(feature_vector);
        outlier_idx = find( (feature_vector<(mean_val-3*std_val)) | (feature_vector>(mean_val+3*std_val)) );
        
        for k=1:length(outlier_idx)
            [r,c]=find(layout==outlier_idx(k));
            mask(r,c)=inf;
        end
        
        for k=1:length(outlier_idx)
            [r,c]=find(layout==outlier_idx(k));
            distanceMatrix=((loc1-loc1(r,c)).^2+(loc2-loc2(r,c)).^2).*mask;
            distanceMatrix(r,c)=inf;
            [neighbor_r,neighbor_c]=find(distanceMatrix==min(min(distanceMatrix)));
            feature_fill=[];
            for u=1:length(neighbor_r)
                feature_fill(u)=feature_vector(layout(neighbor_r(u),neighbor_c(u)));
            end
            feature_vector(outlier_idx(k))=mean(feature_fill);
        end
        featureSmooth(i,(j-1)*batch*skip+q:skip:j*batch*skip)=feature_vector;
    end
end
end

% for m=1:8
%     for n=1:8
%         map(m,n)=feature_vector(64-(m-1)*8-(n-1));
%     end
% end
