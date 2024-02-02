function DASDVfeature=myDASDV(sig)

N=length(sig);

DASDVfeature=0;
for i=1:N-1
    DASDVfeature=DASDVfeature+(sig(i+1)-sig(i)).^2;
end
DASDVfeature=sqrt(DASDVfeature/(N-1));