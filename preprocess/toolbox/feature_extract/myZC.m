function ZCfeature=myZC(sig,thresh)

N=length(sig);

ZCfeature=0;
for i=1:N-1
    if( (abs(sig(i+1)-sig(i))>thresh) && (sig(i)*sig(i+1)<0) )
        ZCfeature=ZCfeature+1;
    end
end