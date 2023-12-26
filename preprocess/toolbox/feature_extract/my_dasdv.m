function dasdv_value=my_dasdv(sig)
N = length(sig); 
Y = 0;
for i = 1 : N - 1
  Y = Y + (sig(i+1) - sig(i)) ^ 2;
end
dasdv_value = sqrt(Y / (N - 1));
end