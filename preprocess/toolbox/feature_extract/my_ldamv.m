function ldamv_value=my_ldamv(sig)
N = length(sig); 
Y = 0;
for t = 1 : N - 1
  Y = Y + abs((sig(t+1) - sig(t)));
end
ldamv_value = log(Y / N);
end