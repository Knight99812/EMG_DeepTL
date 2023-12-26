function ld_value=my_ld(sig)
N = length(sig); 
Y = 0;
for k = 1:N
  Y = Y + log(abs(sig(k))); 
end
ld_value = exp(Y / N);
end