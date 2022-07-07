function base = PreFuncCircular(base, param)
	base = base .* (imfilter(double(base == 0), mkshape(ovaldist(ceil(param)), param), 'same') == 0);
end