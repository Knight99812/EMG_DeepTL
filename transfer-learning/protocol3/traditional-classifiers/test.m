clear;
clc;

data_path = '..\..\..\hybrid-dataset\V1\';
nottouse = [5,11,19,32,38,39];
acc = [];

for i = 1:20
    if ismember(i,nottouse)
        continue
    end
    feature_train = [];
    label_train = [];
    for j = 1:20        % training set
        if j==i || ismember(j,nottouse)
            continue
        end
        for k = 1:2
            load([data_path,'feature\',num2str(j),'_',num2str(k),'.mat'])
            load([data_path,'label\',num2str(j),'_',num2str(k),'.mat'])
            feature_temp = zeros(size(feature,1),1024);
            label_temp = label;
            for p = 1:size(feature,1)
                temp1 = feature(p,1,:,:);
                temp2 = feature(p,2,:,:);
                temp3 = feature(p,3,:,:);
                temp4 = feature(p,4,:,:);
                temp = [temp1(:);temp2(:);temp3(:);temp4(:)];
                feature_temp(p,:) = temp;
            end
            label_train = [label_train;label_temp];
            feature_train = [feature_train;feature_temp];
        end
    end
    [train_xt,~,~] = standardization(feature_train);
    train_yt = label_train;

    for q = 1:2
        load([data_path,'feature\',num2str(i),'_',num2str(q),'.mat'])
        load([data_path,'label\',num2str(i),'_',num2str(q),'.mat'])
        feature_test = zeros(size(feature,1),1024);
        label_test = label;
        for p = 1:size(feature,1)
            temp1 = feature(p,1,:,:);
            temp2 = feature(p,2,:,:);
            temp3 = feature(p,3,:,:);
            temp4 = feature(p,4,:,:);
            temp = [temp1(:);temp2(:);temp3(:);temp4(:)];
            feature_test(p,:) = temp;
        end
        [test_xt,~,~] = standardization(feature_test);
        test_yt = label_test;

        load([data_path,'transfer-data\feature\',num2str(i),'_',num2str(q),'.mat'])
        load([data_path,'transfer-data\label\',num2str(i),'_',num2str(q),'.mat'])
        feature_target = zeros(size(feature_realign_smooth,1),1024);
        label_target = label;
        for p = 1:size(feature_realign_smooth,1)
            temp1 = feature_realign_smooth(p,1,:,:);
            temp2 = feature_realign_smooth(p,2,:,:);
            temp3 = feature_realign_smooth(p,3,:,:);
            temp4 = feature_realign_smooth(p,4,:,:);
            temp = [temp1(:);temp2(:);temp3(:);temp4(:)];
            feature_target(p,:) = temp;
        end
        idx_target = randperm(size(feature_realign_smooth,1),20);
        target_xt = feature_target(idx_target,:);
        target_yt = label_target(idx_target);
        [target_xt,~,~] = standardization(target_xt);

        %% comment out the following 2 lines when TL is not used
%         [Xs_new, ~] = CORAL(train_xt,target_xt);
%         train_xt = Xs_new;

        %% KNN
        mdl = fitcknn(train_xt,train_yt,'NumNeighbors',8);
        predict_label = predict(mdl, test_xt);
        acc_tmp = mean(double((predict_label==test_yt)));
        acc = [acc;acc_tmp];

        %% LDA
%         mdl = ClassificationDiscriminant.fit(train_xt,train_yt);
%         predict_label = predict(mdl, test_xt);
%         acc_tmp = mean(double((predict_label==test_yt)));
%         acc = [acc;acc_tmp];

        %% SVM
%         mdl = svmtrain(train_yt,train_xt,'-t 0');
%         label_zero = zeros(length(test_yt),1);
%         predict_label = svmpredict(label_zero,test_xt,mdl);
%         acc_tmp = mean(double((predict_label==test_yt)));
%         acc = [acc;acc_tmp];

        %% RF
%         mdl = TreeBagger(300,train_xt,train_yt,'Method','classification');
%         predict_label = zeros(length(test_yt),1);
%         result = predict(mdl, test_xt);
%         for rf = 1:length(test_yt)
%             predict_label(rf) = str2double(result{rf});
%         end
%         acc_tmp = mean(double((predict_label==test_yt)));
%         acc = [acc;acc_tmp];

    end
end

acc = acc * 100;
avgacc = mean(acc)



