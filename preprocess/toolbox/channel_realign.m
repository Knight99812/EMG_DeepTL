function feature_realign = channel_realign(feature,feature_num)

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
feature_realign = zeros(size(feature,1),feature_num,16,16);
for p = 1:size(feature,1)
    for q = 1:feature_num
        temp = feature(p,256*q-255:256*q);
        for m = 1:16
            for n = 1:16
                feature_realign(p,q,m,n) = temp(idx(m,n));
            end
        end
    end
end

