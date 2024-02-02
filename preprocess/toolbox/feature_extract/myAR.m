function ARfeature=myAR(sig,order)

N=2*floor(length(sig)/2); % sample number should be an even number
sig2=double(sig(1:N)'); % column vector

model=ar(sig2,order);
ARfeature=model.A(2:end);