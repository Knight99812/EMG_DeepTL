function wl_value=my_wl(sig,fs)

N=length(sig);

wl_value=0;
for i=1:N-1
    wl_value=wl_value+abs(sig(i+1)-sig(i));
end

wl_value=wl_value/N*fs;