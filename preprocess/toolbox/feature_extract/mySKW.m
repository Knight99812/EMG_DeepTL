function SKWValue=mySKW(sig)

N=length(sig);

meanV=mean(sig);
tmp1=1/N*sum((sig-meanV).^3);
tmp2=(1/N*sum((sig-meanV).^2)).^(3/2);

SKWValue=tmp1/tmp2;