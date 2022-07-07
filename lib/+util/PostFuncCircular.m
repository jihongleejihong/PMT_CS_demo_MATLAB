function base = PostFuncCircular(base, param, mx, my)
	base = base .* min(max(sqrt(mx .^ 2 + my.^ 2) - (param / 2), 0), 1);
end