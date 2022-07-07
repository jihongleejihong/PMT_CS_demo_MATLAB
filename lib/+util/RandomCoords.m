function cmat = RandomCoords(mask, params, prefunc, postfunc)
	[h, w] = size(mask);
	hh = round(h / 2);
	hw = round(w / 2);
	base = rand(h, w) .* mask;
	[mx, my] = meshgrid((1:w) - hw, (1:h) - hh);

	n = size(params, 2);
	cmat = zeros(2, n);
	for i = 1:n
		tmpbase = prefunc(base, params(:, i));
		[~, x] = max(max(tmpbase, [], 1));
		[~, y] = max(max(tmpbase, [], 2));
		%[~, x] = max(max(base, [], 1));
		%[~, y] = max(max(base, [], 2));
		base = postfunc(base, params(:, i), mx - x + hw, my - y + hh);
		cmat(:, i) = [x - hw; y - hh];
	end
end