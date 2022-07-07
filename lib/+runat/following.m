function test = following(n_trial, exclude)
	if ~exist('exclude', 'var') || isempty(exclude)
		exclude = [];
	end
	test = @(n, ~, ~) any(mod(n, n_trial) == 1) && ~any(n == exclude);
end