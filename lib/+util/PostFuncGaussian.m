function base = PostFuncGaussian(base, param, mx, my)
	base = base .* (1 - exp(-(mx .^ 2 + my .^ 2) / (2 * param .^ 2.2)));
end