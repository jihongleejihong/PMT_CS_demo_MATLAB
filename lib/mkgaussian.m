function mat = mkgaussian(mat, sd)
	assert(ndims(mat) == 2 && ~isempty(mat), 'dist. matrix (1st arg.) should be a m-by-n matrix'); %#ok<ISMAT>
	assert(isscalar(sd) && sd > 0, 'std. dev. (2nd arg.) should be a positive scalar');

	mat = exp(-.5 * (mat / sd) .^ 2);
end