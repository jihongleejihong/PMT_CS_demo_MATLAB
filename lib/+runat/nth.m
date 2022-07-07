function test = nth(n_trial)
	test = @(n, ~, ~) any(n == n_trial);
end