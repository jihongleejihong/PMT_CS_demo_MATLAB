function dmat = expdata(emat, rows, cols, results, datafunc, showhead)
	if ~exist('datafunc', 'var') || isempty(datafunc)
		datafunc = @(x) sum(x(:));
	end
	if ~exist('showhead', 'var') || isempty(showhead)
		showhead = true;
	end

	n = size(emat, 1);
	rmat = unique(emat(:, rows), 'rows');
	[r_rmat, c_rmat] = size(rmat);
	cmat = unique(emat(:, cols), 'rows');
	[r_cmat, c_cmat] = size(cmat);

	if ~showhead
		c_cmat = 0;
		c_rmat = 0;
	end
	dmat = zeros(c_cmat + r_rmat, c_rmat + r_cmat);
	if showhead
		dmat(c_cmat + (1:r_rmat), 1:c_rmat) = rmat;
		dmat(1:c_cmat, c_rmat + (1:r_cmat)) = cmat';
	end

	for r = 1:r_rmat
		for c = 1:r_cmat
			data = emat(all(emat(:, rows) == repmat(rmat(r, :), n, 1), 2) & all(emat(:, cols) == repmat(cmat(c, :), n, 1), 2), results);
			dmat(c_cmat + r, c_rmat + c) = datafunc(data);
		end
	end
end