function emav_value=my_emav(sig)
L = length(sig); 
Y = 0;
for i = 1:L
  if i >= 0.2 * L  &&  i <= 0.8 * L
    p = 0.75;
  else
    p = 0.5;
  end
  Y = Y + abs(sig(i) ^ p);
end
emav_value = Y / L;
end