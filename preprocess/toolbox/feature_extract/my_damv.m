function damv_value=my_damv(sig)
N = length(sig); 
Y = 0;
for i = 1 : N - 1
  Y = Y + abs(sig(i+1) - sig(i));
end
damv_value = Y / (N - 1);
end