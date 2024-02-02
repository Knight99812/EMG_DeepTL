function vare_value=my_vare(sig)
N   = length(sig); 
vare_value = (1 / (N - 1)) * sum(sig .^ 2);
end