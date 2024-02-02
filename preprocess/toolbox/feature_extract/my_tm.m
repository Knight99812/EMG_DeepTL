function tm_value=my_tm(sig)
% Parameter
order = 3;    % order

% if isfield(opts,'order'), order = opts.order; end

N  = length(sig);
tm_value = abs((1 / N) * sum(sig .^ order));
end
