function HGfeature=myHG(sig,kmax)

N=length(sig);

for k=1:kmax
    for m=1:k
        tmp=0;
        for i=1:floor((N-m)/k)
            tmp=tmp+abs(sig(m+i*k)-sig(m+(i-1)*k)*k);
        end
        L(m,k)=1/k*tmp*(N-1)/floor((N-m)/k)/k;
    end
end

for k=1:kmax
    L_average(k)=mean(L(1:k,k));
end

x=log10(1:kmax);
y=double(log10(L_average));

a=polyfit(x,y,1);
HGfeature=-a(1);