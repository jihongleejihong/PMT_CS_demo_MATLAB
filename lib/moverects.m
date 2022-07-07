function rects = moverects(rects, dx, dy)
	n_rects = size(rects, 2);
	if isscalar(dx)
		dx = repmat(dx, 1, n_rects);
	end
	if isscalar(dy)
		dy = repmat(dy, 1, n_rects);
	end
	rects = rects + repmat([dx; dy], 2, 1);
end