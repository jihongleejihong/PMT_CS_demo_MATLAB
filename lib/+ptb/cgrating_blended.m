function gratingmat = cgrating_blended(varargin)
%CGRATING_BLENDED Generates a 3-layer matrix (RGB) containing a chromatic
%sinusoidal grating blended to the background color.
%
%   Example:
%      <a href="matlab:ptb.imshow_alpha(ptb.cgrating_blended(400, [], [], [], [], .01, [], 45, 120));">ptb.imshow_alpha(ptb.cgrating_blended(400, [], [], [], [], .01, [], 45, 120));</a>
%
%   See also CGRATING_ALPHA, GRATING_ALPHA, GRATING_BLENDED.

	rows    = pretina_arg(varargin, 1,  mfilename, 'rows',    [],                  {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	cols    = pretina_arg(varargin, 2,  mfilename, 'cols',    rows,                {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	bgcolor = pretina_arg(varargin, 5,  mfilename, 'bgcolor', [127.5 127.5 127.5], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan', 'size', [1 3]});

	if length(varargin) >= 4
		gratingmat = ptb.cgrating_alpha(varargin{[1:4, 6:end]});
	else
		gratingmat = ptb.cgrating_alpha(varargin{:});
	end
	gratingmat(:, :, end) = gratingmat(:, :, end) ./ 255;
	gratingmat = apply_alpha( ...
		rgb2map(bgcolor, rows, cols), ...
		gratingmat ...
		);
end