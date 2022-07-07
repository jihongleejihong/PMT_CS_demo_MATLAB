function gratingmat = cgrating_alpha(varargin)
%CGRATING_ALPHA Generates a 4-layer matrix (RGB and alpha) containing a
%chromatic sinusoidal grating.
%
%   Example:
%      <a href="matlab:ptb.imshow_alpha(ptb.cgrating_alpha(400, [], [], [], .01, [], 45, 120));">ptb.imshow_alpha(ptb.cgrating_alpha(400, [], [], [], .01, [], 45, 120));</a>
%
%   See also CGRATING_BLENDED, GRATING_ALPHA, GRATING_BLENDED.

	rows       = pretina_arg(varargin, 1,  mfilename, 'rows',       [],        {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	cols       = pretina_arg(varargin, 2,  mfilename, 'cols',       rows,      {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	color1     = pretina_arg(varargin, 3,  mfilename, 'color1',     [255 0 0], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan', 'size', [1 3]});
	color2     = pretina_arg(varargin, 4,  mfilename, 'color2',     [0 255 0], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan', 'size', [1 3]});
	sine_freq  = pretina_arg(varargin, 5,  mfilename, 'sine_freq',  [],        {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});
	sine_phase = pretina_arg(varargin, 6,  mfilename, 'sine_phase', 90,        {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});
	sine_tilt  = pretina_arg(varargin, 7,  mfilename, 'sine_tilt',  0,         {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});
	env_radius = pretina_arg(varargin, 8,  mfilename, 'env_radius', [],        {'numeric'}, {'scalar', 'real', 'finite', 'nonnan', 'positive'});
	env_ratio  = pretina_arg(varargin, 9,  mfilename, 'env_ratio',  1,         {'numeric'}, {'scalar', 'real', 'finite', 'nonnan', 'positive'});
	env_tilt   = pretina_arg(varargin, 10, mfilename, 'env_tilt',   0,         {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});

	sinemat = apply_alpha( ...
		rgb2map(color2, rows, cols), rgb2map(color1, rows, cols), ...
		mk_grating(map_linear(rows, cols, sine_tilt), sine_freq, sine_phase) ...
		);
	envmat = mk_shape(map_radial(rows, cols, env_ratio, env_tilt), env_radius);
	gratingmat = cat(3, sinemat, envmat * 255);
end