function mat = expmat(varargin)
	mat = [];
	n = 1;
	for argin = varargin(end:-1:1)
		conds = cell2mat(argin);
		[rows, cols] = size(conds);
		mat = [reshape(repmat(conds', n, 1), cols, n * rows)', repmat(mat, rows, 1)];
		n = n * rows;
	end
end