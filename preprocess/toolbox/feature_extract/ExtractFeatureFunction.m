% 改文件用于摘取road文件下所有的分割好的数据的特征。
function  ExtractFeatureFunction(road, sel_channel, outFile)


window_len=0.75; % 0.75 s sliding window to extract features
step_len=0.75;

zc_ssc_thresh=0.0004; %threshold to detect valid zero cross and slope sign change features
fs_emg=2048;
Nsample=ceil(window_len*fs_emg);
namelist = dir([road]);
% sel_channel = [1,2,3,4,5,6,7,8,16,11,12,13,14,15,10,9,17,18,19,...
%     49,41,42,43,44,50,51,52,53,54,62,63,64,56,55,61,60,59,58,57];
for i = 3 : size(namelist)
    FullRoadData = [road, namelist(i).name, '\PR\sit\preprocessed_sit_dyn.mat'];
    FullRoadLabel = [road, namelist(i).name, '\PR\sit\label_sit_dyn.mat'];
    namelist(i).name
    if exist (FullRoadData,'File')>0
        load (FullRoadData);
        load (FullRoadLabel);
        if size(preprocessed_dyn,2) == size(label_dyn,2)
            OutFile = [outFile,namelist(i).name,'.mat'];
            
%             if exist(OutFile,'file')==0
                for j = 1:size(label_dyn,2)
                    emg= preprocessed_dyn{1,j}(end-Nsample+1:end,:);
                    emg = emg(:,sel_channel);
                    rms_tmp=get_rms(emg,window_len,step_len,fs_emg);
                    rms=reshape(rms_tmp,[1,numel(rms_tmp)]);
                    wl_tmp=get_wl(emg,window_len,step_len,fs_emg);
                    wl=reshape(wl_tmp,[1,numel(wl_tmp)]);
                    zc_tmp=get_zc(emg,window_len,step_len,zc_ssc_thresh,fs_emg);
                    zc=reshape(zc_tmp,[1,numel(zc_tmp)]);
                    ssc_tmp=get_ssc(emg,window_len,step_len,zc_ssc_thresh,fs_emg);
                    ssc=reshape(ssc_tmp,[1,numel(ssc_tmp)]);
                    feature(:,j)=[rms';wl';zc';ssc'];
                    if exist(outFile,'dir')==0
                        mkdir(outFile);
                    end
                    save(OutFile,'feature','label_dyn')
%                 end
            end
        end
    else
        disp([FullRoadData, 'is not exist.']);
    end
end

end