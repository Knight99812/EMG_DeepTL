function MAXfeature=myMAX(sig,b,a)

filter_sig=filter(b,a,double(sig)');

MAXfeature=max(filter_sig);