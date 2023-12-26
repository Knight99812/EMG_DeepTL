function [feature_train_norm,feature_test_norm]=myFeatureNorm1(feature_train,feature_test)

meanV=mean(feature_train);
stdV=std(feature_train);

idx=find(stdV==0);
stdV(idx)=1;

feature_train_norm=(feature_train-ones(size(feature_train,1),1)*meanV)./(ones(size(feature_train,1),1)*stdV);
feature_test_norm=(feature_test-ones(size(feature_test,1),1)*meanV)./(ones(size(feature_test,1),1)*stdV);