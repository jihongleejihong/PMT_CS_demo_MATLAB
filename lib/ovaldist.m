function mat = ovaldist(im_size, split, tilt)
	if ~exist('split', 'var') split = 0; else split = abs(split);     end %#ok<SEPEX>
	if ~exist('tilt',  'var') tilt  = 0; else tilt  = mod(tilt, 180); end %#ok<SEPEX>
	assert(isscalar(im_size) && im_size > 0, 'image size (1st arg.) should be a positive integer');
	assert(isscalar(split) && split >= 0, 'split b/w foci (2nd arg.) should be greater than or equal to 0');
	assert(isscalar(tilt), 'tilt angle (3rd arg.) should be a scalar');

	px = split / 2 * sind(tilt);
	py = - split / 2 * cosd(tilt);
	[mx, my] = meshgrid(((1 - im_size) / 2):((im_size - 1) / 2));
	mat = (sqrt((mx - px) .^ 2 + (my - py) .^ 2) + sqrt((mx + px) .^ 2 + (my + py) .^ 2)) / 2 - split / 2;
end