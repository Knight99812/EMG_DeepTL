function mmav_value=my_mmav(sig)
N = length(sig); 
Y = 0;
for i = 1:N
  if i >= 0.25 * N  &&  i <= 0.75 * N
    w = 1; 
  else
    w = 0.5;
  end
  Y = Y + (w * abs(sig(i)));
end
mmav_value = (1 / N) * Y;
end