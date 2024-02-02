function WLfeature=myWL(sig)

N=length(sig);

WLfeature=0;
for i=1:N-1
    WLfeature=WLfeature+abs(sig(i+1)-sig(i));
end