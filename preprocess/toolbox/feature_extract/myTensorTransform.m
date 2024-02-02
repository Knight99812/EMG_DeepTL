function featureTensor=myTensorTransform(featureVec_ori)
% featureTensor: 4-order: time, different kinds of features, column number, row
% number

Nfeature=length(featureVec_ori)/256;

for k=1:Nfeature
    featureVec=featureVec_ori((k-1)*256+1:k*256);
    featureMap=vector2map(featureVec);
    featureTensorTmp=[[featureMap(:,:,1);featureMap(:,:,2)],[featureMap(:,:,3);featureMap(:,:,4)]];
    featureTensor(1,k,:,:)=featureTensorTmp;
end