function h = Pashler_H(dmat)
	n = dmat(1, 1);
	hit = mean(dmat(dmat(:, 2) ~= 0, 3));
	fa = 1 - mean(dmat(dmat(:, 2) == 0, 3));
	h = n * (hit - fa) / (1 - fa);
end