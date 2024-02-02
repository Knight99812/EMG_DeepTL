function SSIfeature=mySSI(sig)

N=length(sig);

SSIfeature=0;
for i=1:N
    SSIfeature=SSIfeature+(sig(i))^2;
end