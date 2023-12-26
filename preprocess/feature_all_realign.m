clear all;
close all;
clc;

V1_path = 'E:\EMG\EMG_DeepTL\data\V1\';     % data path
V2_path = 'E:\EMG\EMG_DeepTL\data\V2\';


idx = zeros(16,16);
for i = 1:8
    for j = 1:8
        idx(i,j) = 201-j-8*i;
    end
end
for i = 1:8
    for j = 1:8
        idx(i+8,j) = 265-j-8*i;
    end
end
for i = 1:8
    for j = 1:8
        idx(i,j+8) = 73-j-8*i;
    end
end
for i = 1:8
    for j = 1:8
        idx(i+8,j+8) = 137-j-8*i;
    end
end

for i = 1:41
    for j = 1:2
        if i <= 20
            data_path = V1_path;
        else
            data_path = V2_path;
        end
        load([data_path,'feature_all/',num2str(i),'_',num2str(j),'.mat']);
        feature_realign = zeros(size(feature,2),43,16,16);
        
        for p = 1:size(feature,2)
            for q = 1:43
                temp = feature(256*q-255:256*q,p)';
                for m = 1:16
                    for n = 1:16
                        feature_realign(p,q,m,n) = temp(idx(m,n));
                    end
                end
            end
        end
        save([data_path,'feature_all_realign\',num2str(i),'_',num2str(j),'.mat'],'feature_realign');
    end
end