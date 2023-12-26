function mmav2_value=my_mmav2(sig)
N = length(sig); 
Y = 0;
for i = 1:N
  if i >= 0.25 * N  &&  i <= 0.75 * N
    w = 1;
  elseif i < 0.25 * N
    w = (4 * i) / N;
  else
    w = 4 * (i - N) / N;
  end
  Y = Y + (w * abs(sig(i)));
end
mmav2_value = (1 / N) * Y;
end