function mat = mkgrating(mat, freq, phase)
	if ~exist('phase', 'var') phase = 0; else phase = mod(phase, 360); end %#ok<SEPEX>
	assert(ndims(mat) == 2 && ~isempty(mat), 'dist. matrix (1st arg.) should be a m-by-n matrix'); %#ok<ISMAT>
	assert(isscalar(freq) && freq > 0, 'frequency (2nd arg.) should be a positive scalar');
	assert(isscalar(phase), 'phase (3rd arg.) should be a scalar');

	mat = .5 + .5 * sind(phase + mat * freq * 360);
end