function [seq, mat, n] = expseq(mat, reps, iblk, iseq)
	% validate arguments
	assert(ndims(mat) == 2 && numel(mat) > 0, 'exp. matrix (1st arg.) should be m-by-n matrix'); %#ok<ISMAT>
	if ~exist('reps', 'var') || isempty(reps) reps = 1; end %#ok<SEPEX>
	if ~exist('iseq', 'var') || isempty(iseq) iseq = 1; end %#ok<SEPEX>
	if ~exist('iblk', 'var') || isempty(iblk) iblk = iseq; end %#ok<SEPEX>
	assert(isscalar(reps) && reps > 0, 'repititions (2nd arg.) should be positive integer');
	assert(isscalar(iblk) && iblk > 0, 'intermixed blocks (3rd arg.) should be positive integer');
	assert(isscalar(iseq) && iseq > 0, 'interleave sequences (4th arg.) should be positive integer');
	assert(mod(reps, iblk) == 0, 'repetitions (2nd arg.) should be multiple of intermixed blocks (3rd arg.)');
	assert(mod(reps, iseq) == 0, 'repetitions (2nd arg.) should be multiple of interleave sequences (4th arg.)');
	assert(mod(iblk, iseq) == 0, 'intermixed blocks (3rd arg.) should be multiple of interleave sequences (4th arg.)');

	% replicate exp. matrix
	[rows, cols] = size(mat);
	if (iseq > 1)
		mat = [reshape(repmat(mat, 1, iseq)', cols, rows * iseq)', repmat((1:iseq)', rows, 1)];
	end
	mat = repmat(mat, reps / iseq, 1);

	% prepare random sequence
	n = rows * reps;
	irow = rows * iblk;
	seq = zeros(1, n);
	for b = 1:irow:n
		for s = 1:iseq
			seq(b - 1 + (s:iseq:irow)) = b + s - 1 + (randperm(irow / iseq) - 1) * iseq;
		end
	end
	
	% prepend sequence order to exp. matrix
	mat_seq(seq) = 1:length(seq);
	mat = [mat_seq', mat];
end