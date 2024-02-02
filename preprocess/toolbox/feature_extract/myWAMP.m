function WAMPfeature=myWAMP(sig,thresh)

N=length(sig);

WAMPfeature=0;
for i=1:N-1
    if(abs(sig(i+1)-sig(i))>thresh)
        WAMPfeature=WAMPfeature+1;
    end
end