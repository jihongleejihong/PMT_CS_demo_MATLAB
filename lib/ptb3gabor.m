function mat = ptb3gabor(im_size, meanlum, contrast, freq, phase, tilt, sd, split, tilt2)
	if ~exist('meanlum',  'var') || isempty(meanlum)  meanlum  = 127.5; end %#ok<SEPEX>
	if ~exist('contrast', 'var') || isempty(contrast) contrast = 1;     end %#ok<SEPEX>
	if ~exist('phase', 'var')    || isempty(phase)    phase = 0; else phase = mod(phase, 360); end %#ok<SEPEX>
	if ~exist('tilt', 'var')     || isempty(tilt)     tilt  = 0; else tilt  = mod(tilt,  180); end %#ok<SEPEX>
	if ~exist('split', 'var')    || isempty(split)    split = 0; else split = abs(split);      end %#ok<SEPEX>
	if ~exist('tilt2',  'var')   || isempty(tilt2)    tilt2 = 0; else tilt2 = mod(tilt2, 180); end %#ok<SEPEX>
	assert(isscalar(im_size) && im_size > 0, 'image size (1st arg.) should be a positive integer');
	assert(isscalar(meanlum) && meanlum >= 0, 'mean luminance (2nd arg.) should be greater than or equal to 0');
	assert(isscalar(contrast) && contrast >= 0, 'contrast (3rd arg.) should be greater than or equal to 0');

	mat = meanlum * (1 + (mkgrating(lineardist(im_size, tilt), freq, phase) * 2 - 1) * contrast);
	mat(:, :, 2) = mkgaussian(ovaldist(im_size, split, tilt2), sd) * 255;
end