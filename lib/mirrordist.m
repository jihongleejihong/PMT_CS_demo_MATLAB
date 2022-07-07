function mat = mirrordist(im_size, ltilt, rtilt)
	if ~exist('ltilt', 'var') ltilt = 0; else ltilt = mod(ltilt, 360); end %#ok<SEPEX>
	if ~exist('rtilt', 'var') rtilt = ltilt; else rtilt = mod(rtilt, 360); end %#ok<SEPEX>
	assert(isscalar(im_size) && im_size > 0, 'image size (1st arg.) should be a positive integer');
	assert(isscalar(ltilt) && isscalar(rtilt), 'left tilt angle (2nd arg.) and right tilt angle (3rd arg.) should be scalars');

	lmat = lineardist(im_size, ltilt);
	rmat = lineardist(im_size, rtilt);
	mat = [ ...
			lmat(:, round(im_size / 2):-1:(1 + mod(im_size, 2))), ...
			rmat(:, 1:round(im_size / 2)) ...
			] - (mod(im_size, 2) / 2);
end