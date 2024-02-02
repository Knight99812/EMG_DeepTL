function wa_value=my_wa(sig)
thres = 0.01;    % threshold

% if isfield(opts,'thres'), thres = opts.thres; end

N  = length(sig); 
wa_value = 0; 
for k = 1 : N - 1 
  if abs(sig(k) - sig(k+1)) > thres
    wa_value = wa_value + 1; 
  end
end
end