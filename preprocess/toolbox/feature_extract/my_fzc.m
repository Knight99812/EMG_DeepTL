function fzc_value=my_fzc(sig)
L   = length(sig); 
fzc_value = 0;
% Compute T (21)
T = 4 * ((1/10) * sum(sig(1 : 10)));
% Compute proposed zero crossing (20)
for i = 1 : L - 1
  if (sig(i) > T  &&  sig(i+1) < T)  ||  (sig(i) < T  &&  sig(i+1) > T)
    fzc_value = fzc_value + 1;
  end
end
end