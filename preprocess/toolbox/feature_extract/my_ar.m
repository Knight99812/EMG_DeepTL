function ar_value=my_ar(sig)
% Parameter
order = 4;    % order

% if isfield(opts,'order'), order = opts.order; end

Y  = arburg(sig,order); 
% First index is meaningless
ar_value = Y(2 : order + 1); 
end