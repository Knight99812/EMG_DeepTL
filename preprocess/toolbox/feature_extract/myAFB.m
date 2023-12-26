function AFBfeature=myAFB(sig,fs,Wf)

sig=sig.^2;

N=length(sig);

windowLength=round(fs*Wf/1000);

hammingWindow=hamming(windowLength)';

for i=windowLength:N
    filterOut(i-windowLength+1)=sum(hammingWindow.*sig(i-windowLength+1:i));
end

[maxV,maxIdx]=findpeaks(filterOut);
if(max(filterOut)==filterOut(1))
    AFBfeature=filterOut(1);
else
    AFBfeature=maxV(1);
end