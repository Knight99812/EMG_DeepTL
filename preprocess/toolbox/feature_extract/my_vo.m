function vo_value=my_vo(sig)
% Parameter
order = 2;     % order

% if isfield(opts,'order'), order = opts.order; end

N  = length(sig); 
Y  = (1 / N) * sum(sig .^ order);
vo_value = Y ^ (1 / order); 
end
