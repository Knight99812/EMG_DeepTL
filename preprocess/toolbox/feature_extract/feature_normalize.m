function [feature_train_norm,feature_test_norm]=feature_normalize(feature_train,feature_test,pca_active,dim)

% if pca_active==1,perform pca to reduce the dimensionality of features to dim.

if iscell(feature_train) == 0, feature_train = {feature_train}; end
if iscell(feature_test) == 0, feature_test = {feature_test}; end

N_train_trial=length(feature_train);

feature_train_concat=[];
for i=1:N_train_trial
    feature_train_concat=[feature_train_concat,feature_train{1,i}];
end

mean_val=mean(feature_train_concat,2);
std_val=std(feature_train_concat')';

if(pca_active==1)
    feature_train_concat=(feature_train_concat-mean_val)./std_val;
    covx=cov(feature_train_concat');
    [WPCA,LATENT] = pcacov(covx);
end

for i=1:N_train_trial
    tmp=(feature_train{1,i}-mean_val)./std_val;
    if(pca_active==1)
        tmp=tmp'*WPCA(:,1:dim);
        tmp=tmp';
    end
    feature_train_norm{1,i}=tmp;
end

N_test_trial=length(feature_test);
for i=1:N_test_trial
    tmp=(feature_test{1,i}-mean_val)./std_val;
    if(pca_active==1)
        tmp=tmp'*WPCA(:,1:dim);
        tmp=tmp';
    end
    feature_test_norm{1,i}=tmp;
end

if length(feature_test_norm)==1, feature_test_norm = feature_test_norm{1}; end
if length(feature_train_norm)==1, feature_train_norm = feature_train_norm{1}; end
    

    