function MHWfeature=myMHW(sig,windowNum,overlap)

N=length(sig);
windowLength=floor(N/(windowNum+overlap-windowNum*overlap));
overlapNum=floor(windowLength*overlap);

for i=1:windowNum
    window=zeros(1,N);
    beginIdx=(i-1)*(windowLength-overlapNum)+1;
    endIdx=beginIdx+windowLength-1;
    window(beginIdx:endIdx)=hamming(windowLength)/sum(hamming(windowLength));
    window=window(1:N);
    MHWfeature(i)=sum((window.*sig).^2);
end