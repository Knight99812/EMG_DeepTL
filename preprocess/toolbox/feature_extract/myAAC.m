function AACfeature=myAAC(sig)

N=length(sig);

AACfeature=0;
for i=1:N-1
    AACfeature=AACfeature+abs(sig(i+1)-sig(i));
end

AACfeature=AACfeature/N;