function featureTensor=myFeatureTensor(featureVec_ori)
% featureTensor: 4-order: time, different kinds of features, column number, row
% number

Nfeature=length(featureVec_ori)/256;

for k=1:Nfeature
    featureVec=featureVec_ori(k:Nfeature:length(featureVec_ori));
    featureMap=vector2map(featureVec);
    featureTensorTmp=[[featureMap(:,:,1);featureMap(:,:,2)],[featureMap(:,:,3);featureMap(:,:,4)]];
    featureTensor(1,k,:,:)=featureTensorTmp;
end
