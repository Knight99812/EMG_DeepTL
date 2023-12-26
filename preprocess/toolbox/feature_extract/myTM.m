function TMfeature=myTM(sig,order)

N=length(sig);
sig=sig*100;% amplify the signal to avoid data overflow
TMfeature=abs(1/N*sum(sig.^order));