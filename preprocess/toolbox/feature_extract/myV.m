function Vfeature=myV(sig,order)

sig_order=sig.^order;
Vfeature=nthroot( mean(sig_order),order );