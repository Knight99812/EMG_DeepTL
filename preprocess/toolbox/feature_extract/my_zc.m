function zc_value=my_zc(sig,thresh)

N=length(sig);

zc_value=0;
for i=1:N-1
    if( (abs(sig(i+1)-sig(i))>thresh) && (sig(i)*sig(i+1)<0) )
        zc_value=zc_value+1;
    end
end