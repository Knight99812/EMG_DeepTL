function msr_value=my_msr(sig)
K   = length(sig); 
msr_value = (1 / K) * sum(sig .^ (1/2));
end