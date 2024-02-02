function ssc_value=my_ssc(sig,thresh)

N=length(sig);

ssc_value=0;
for i=2:N-1
    if( ((sig(i)-sig(i-1))*(sig(i)-sig(i+1))>0) && ( (abs(sig(i+1)-sig(i))>thresh) || (abs(sig(i-1)-sig(i))>thresh) ) )
        ssc_value=ssc_value+1;
    end
end