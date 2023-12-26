function MAVS_feature=MAVS_extract(EMG,MAVS_seg_num)

Nchannel=size(EMG,1);

MAVS_feature=[];
idx_end=1;
seg_length=floor(size(EMG,2)/MAVS_seg_num);

for i=1:MAVS_seg_num
    idx_begin=idx_end;
    idx_end=idx_begin+seg_length-1;
    sig=EMG(:,idx_begin:idx_end);
    for j=1:Nchannel
        MAV(i,j)=mean(abs(sig(j,:)));
    end
end

MAV_diff=diff(MAV);
MAVS_feature=double(reshape(MAV_diff,[1,size(MAV_diff,1)*size(MAV_diff,2)]));