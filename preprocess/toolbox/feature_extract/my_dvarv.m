function dvarv_value=my_dvarv(sig)
N = length(sig); 
Y = 0;
for i = 1 : N - 1
  Y = Y + (sig(i+1) - sig(i)) ^ 2;
end
dvarv_value = Y / (N - 2);
end