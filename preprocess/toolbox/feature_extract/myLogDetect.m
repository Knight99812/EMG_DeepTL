function LogDetectfeature=myLogDetect(sig)

N=length(sig);

LogDetectfeature=exp(1)^(sum(log(abs(sig)))/N);