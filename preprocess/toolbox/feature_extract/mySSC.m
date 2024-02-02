function SSCfeature=mySSC(sig,thresh)

N=length(sig);

SSCfeature=0;
for i=2:N-1
    if( ((sig(i)-sig(i-1))*(sig(i)-sig(i+1))>0) && ( (abs(sig(i+1)-sig(i))>thresh) || (abs(sig(i-1)-sig(i))>thresh) ) )
        SSCfeature=SSCfeature+1;
    end
end