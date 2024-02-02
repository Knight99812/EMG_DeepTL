function aac_value=my_aac(sig)
N = length(sig); 
Y = 0;
for i = 1 : N - 1
  Y = Y + abs(sig(i + 1) - sig(i));
end
aac_value = Y / N;
end