function k = Cowan_K(dmat)
	n = dmat(1, 1);
	hit = mean(dmat(dmat(:, 2) ~= 0, 3));
	fa = 1 - mean(dmat(dmat(:, 2) == 0, 3));
	k = n * (hit - fa);
end