function ewl_value=my_ewl(sig)
L   = length(sig); 
ewl_value = 0;
for i = 2:L
  if i >= 0.2 * L  &&  i <= 0.8 * L
    p = 0.75;
  else
    p = 0.5;
  end
  ewl_value = ewl_value + abs((sig(i) - sig(i-1)) ^ p); 
end
end
