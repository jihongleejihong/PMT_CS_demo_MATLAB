function [seq, mat, n] = expblock(bseq, bmat, cond, varargin)
	emats = cell(size(bseq))';
	n = 0;
	for b = bseq
		bcond = bmat(b, :);
		emat = expmat(bcond, cond);
		[~, emat] = expseq(emat, varargin{:});
		emat(:, 1) = emat(:, 1) + n;
		n = n + size(emat, 1);
		emats{b} = emat;
	end
	mat = cell2mat(emats);
	seq(mat(:, 1)') = 1:size(mat, 1);
end