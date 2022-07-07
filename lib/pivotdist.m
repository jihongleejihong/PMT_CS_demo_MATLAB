function mat = pivotdist(im_size, symmetric)
	assert(isscalar(im_size) && im_size > 0, 'image size (1st arg.) should be a positive integer');
	if ~exist('symmetric', 'var') || isempty(symmetric) symmetric = false; end %#ok<SEPEX>
	[mx, my] = meshgrid(((1 - im_size) / 2):((im_size - 1) / 2));
	if symmetric mx = abs(mx); end %#ok<SEPEX>
	mat = xy2angle(mx, my);
end