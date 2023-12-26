function MTWfeature=myMTW(sig,windowNum,overlap)

N=length(sig);
windowLength=floor(N/(windowNum+overlap-windowNum*overlap));
overlapNum=floor(windowLength*overlap);

x=[1:windowLength];
trapezoidalWindow=trapmf(x,[1,floor(overlap*windowLength),windowLength-floor(overlap*windowLength),windowLength]);

for i=1:windowNum
    window=zeros(1,N);
    beginIdx=(i-1)*(windowLength-overlapNum)+1;
    endIdx=beginIdx+windowLength-1;
    window(beginIdx:endIdx)=trapezoidalWindow/sum(trapezoidalWindow);
    window=window(1:N);
    MTWfeature(i)=sum((window.*sig).^2);
end