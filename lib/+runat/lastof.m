function test = lastof(seq)
	test = @(n, ~, ~) n == length(seq);
end