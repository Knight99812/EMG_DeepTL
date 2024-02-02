function asm_value=my_asm(sig)
K = length(sig); 
Y = 0; 
for n = 1:K
  if n >= 0.25 * K  &&  n <= 0.75 * K
    exp = 0.5;
  else
    exp = 0.75;
  end
  Y = Y + (sig(n) ^ exp);
end
asm_value = abs(Y / K);
end
