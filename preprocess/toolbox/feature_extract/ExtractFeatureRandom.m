% 改文件用于摘取road文件下所有的分割好的数据的特征。
function accuracy = ExtractFeatureRandom(road, sel_channel)
UsedLabel = [1:5];

window_len=0.75; % 0.75 s sliding window to extract features
step_len=0.75;

zc_ssc_thresh=0.0004; %threshold to detect valid zero cross and slope sign change features
fs_emg=2048;
Nsample=ceil(window_len*fs_emg);
namelist = dir([road]);
n=3;
% sel_channel = [1,2,3,4,5,6,7,8,16,11,12,13,14,15,10,9,17,18,19,...
%     49,41,42,43,44,50,51,52,53,54,62,63,64,56,55,61,60,59,58,57];
for i = 3 : size(namelist)
    FullRoadData = [road, namelist(i).name, '\PR\sit\preprocessed_sit_dyn.mat'];
    FullRoadLabel = [road, namelist(i).name, '\PR\sit\label_sit_dyn.mat'];
    namelist(i).name
    if exist (FullRoadData,'File')>0
        load (FullRoadData);
        load (FullRoadLabel);
        label = label_dyn;
        if size(preprocessed_dyn,2) == size(label_dyn,2)
            for j = 1:size(label_dyn,2)
                emg= preprocessed_dyn{1,j}(end-Nsample+1:end,:);
                emg = emg(:,sel_channel);
                myop_tmp=get_myop(emg,window_len,step_len,fs_emg);
                myop=reshape(myop_tmp,[1,numel(myop_tmp)]);
                mfl_tmp=get_mfl(emg,window_len,step_len,fs_emg);
                mfl=reshape(mfl_tmp,[1,numel(mfl_tmp)]);
                wamp_tmp=get_wamp(emg,window_len,step_len,fs_emg);
                wamp=reshape(wamp_tmp,[1,numel(wamp_tmp)]);
                ssc_tmp=get_ssc(emg,window_len,step_len,zc_ssc_thresh,fs_emg);
                ssc=reshape(ssc_tmp,[1,numel(ssc_tmp)]);
                feature(:,j)=[myop';mfl';wamp';ssc'];
            end
                       
            
            IndexTrain=[];
            uY = unique(label);
            for labelV = 1:size(uY,2)
                temp = find(label==uY(labelV));
                IndexTrain = [IndexTrain,temp(1:n)];
            end
            IndexTest = setdiff([1:size(label,2)],IndexTrain);
            feature_train = feature(:,IndexTrain);
            label_train = label(1,IndexTrain);
            feature_test = feature(:,IndexTest);
            label_test = label(1,IndexTest);
            mdl = ClassificationDiscriminant.fit(feature_train',label_train);
            predict_label = predict(mdl, feature_test');
            accuracy(i-2)=mean(double((predict_label==label_test')));
            accuracy(i-2)
        end
    else
        disp([FullRoadData, 'is not exist.']);
    end
end

end