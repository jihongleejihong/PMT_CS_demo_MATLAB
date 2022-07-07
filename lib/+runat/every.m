function test = every(n_trial, exclude)
	if ~exist('exclude', 'var') || isempty(exclude)
		exclude = [];
	end
	test = @(n, ~, ~) any(mod(n, n_trial) == 0) && ~any(n == exclude);
end