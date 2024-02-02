clear all;
close all;
clc;

V1_path = 'E:\EMG_DeepTL\data\V1\';     % data path
V2_path = 'E:\EMG_DeepTL\data\V2\';

for i = 1:41
    for j = 1:2
        if i <= 20
            data_path = V1_path;
        else
            data_path = V2_path;
        end
        load([data_path,'feature_all_realign\',num2str(i),'_',num2str(j),'.mat']);
        feature_realign_smooth = zeros(size(feature_realign));
        for t = 1:size(feature_realign,1)                                   % trail dim
            for f = 1:43                                                    % feature dim
                A = feature_realign(t,f,1:8,1:8);                           % 左上 电极片3
                B = feature_realign(t,f,1:8,9:16);                          % 右上 电极片1
                C = feature_realign(t,f,9:16,1:8);                          % 左下 电极片4
                D = feature_realign(t,f,9:16,9:16);                         % 右下 电极片2
                A = reshape(A,[8,8]);
                B = reshape(B,[8,8]);
                C = reshape(C,[8,8]);
                D = reshape(D,[8,8]);
                A0 = A(:); B0 = B(:); C0 = C(:); D0 = D(:);
                A_mean = mean(A0); B_mean = mean(B0); C_mean = mean(C0); D_mean = mean(D0); 
                A_std = std(A0); B_std = std(B0); C_std = std(C0); D_std = std(D0); 

                A = channel_smooth(A,A_mean,A_std);
                B = channel_smooth(B,B_mean,B_std);
                C = channel_smooth(C,C_mean,C_std);
                D = channel_smooth(D,D_mean,D_std);
                
                feature_realign_smooth(t,f,1:8,1:8) = A;
                feature_realign_smooth(t,f,1:8,9:16) = B;
                feature_realign_smooth(t,f,9:16,1:8) = C;
                feature_realign_smooth(t,f,9:16,9:16) = D;

            end
        end
        save([data_path,'feature_all_realign_smooth\',num2str(i),'_',num2str(j),'.mat'],'feature_realign_smooth');
    end
end