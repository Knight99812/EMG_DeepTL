function MFLfeature=myMFL(sig)

N=length(sig);

k=1;
m=1;

tmp=0;
for i=1:floor((N-m)/k)
    tmp=tmp+abs(sig(m+i*k)-sig(m+(i-1)*k)*k);
end
L=1/k*tmp*(N-1)/floor((N-m)/k)/k;

MFLfeature=double(log10(L));
