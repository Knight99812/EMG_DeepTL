function EMG_Rest=RestScreen(EMG_preExp)

for j=1:length(EMG_preExp)
    tmp=EMG_preExp{1,j}';
    for i=1:size(tmp,1)
        power(i,j)=var(tmp(i,:));
    end
end

outlierIdx=[];
for i=1:size(power,1)
    tmp=power(i,:);
    thresh=mean(tmp)+2*std(tmp);
    outlierIdx=[outlierIdx,find(tmp>thresh)];
end
outlierIdx=unique(outlierIdx);

for i=1:length(outlierIdx)
    EMG_preExp{1,outlierIdx(i)}=[];
end

EMG_preExp(cellfun(@isempty,EMG_preExp))=[];

EMG_Rest=[];
for i=1:length(EMG_preExp)
    EMG_Rest=[EMG_Rest,EMG_preExp{1,i}'];
end
        
