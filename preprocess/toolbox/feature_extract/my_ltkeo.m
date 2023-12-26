function ltkeo_value=my_ltkeo(sig)
N = length(sig); 
Y = 0; 
for j = 2 : N - 1
  Y = Y + ((sig(j) ^ 2) - sig(j-1) * sig(j+1));
end
ltkeo_value = log(Y);
end