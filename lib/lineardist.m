function mat = lineardist(im_size, tilt, centered)
	if ~exist('tilt',     'var') tilt     = 0; else tilt = mod(tilt, 360); end %#ok<SEPEX>
	if ~exist('centered', 'var') centered = false; end %#ok<SEPEX>
	assert(isscalar(im_size) && im_size > 0, 'image size (1st arg.) should be a positive integer');
	assert(isscalar(tilt), 'tilt angle (2nd arg.) should be a scalar');

	basemat = (.5:(im_size - .5)) - centered * (im_size / 2);
	[mx, my] = meshgrid(basemat);
	mat = (mx * cosd(tilt) + my * sind(tilt));
end