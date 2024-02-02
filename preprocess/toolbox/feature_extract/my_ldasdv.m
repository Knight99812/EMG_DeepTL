function ldasdv_value=my_ldasdv(sig)
N = length(sig); 
Y = 0;
for t = 1 : N - 1
  Y = Y + (sig(t+1) - sig(t)) ^ 2;
end
ldasdv_value = log(sqrt(Y / (N - 1)));
end