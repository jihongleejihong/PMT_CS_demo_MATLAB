function mat = mkshape(mat, d)
	if ~exist('d', 'var') d = min(size(mat)); end %#ok<SEPEX>
	assert(ndims(mat) == 2 && ~isempty(mat), 'dist. matrix (1st arg.) should be a m-by-n matrix'); %#ok<ISMAT>
	assert(isscalar(d), 'diameter (2nd arg.) should a scalar');
	%assert(isscalar(d) && d > 0, 'diameter (2nd arg.) should a positive integer');

	mat = (d * .5 + .5) - mat;
	mat(mat > 1) = 1;
	mat(mat < 0) = 0;
end