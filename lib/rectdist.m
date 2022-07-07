function mat = rectdist(im_size, ratio, tilt)
	if ~exist('ratio', 'var') ratio = 1; else ratio = abs(ratio);     end %#ok<SEPEX>
	if ~exist('tilt',  'var') tilt  = 0; else tilt  = mod(tilt, 180); end %#ok<SEPEX>
	assert(isscalar(im_size) && im_size > 0, 'image size (1st arg.) should be a positive integer');
	assert(isscalar(ratio), 'x to y ratio (2nd arg.) should be a positive scalar');
	assert(isscalar(tilt), 'tilt angle (3rd arg.) should be a scalar');

	[mx, my] = meshgrid(((1 - im_size) / 2):((im_size - 1) / 2));
	tx = (mx * cosd(tilt) + my * sind(tilt));
	ty = (mx * cosd(tilt + 90) + my * sind(tilt + 90));
	mat = max(abs(tx) * ratio, abs(ty));
end