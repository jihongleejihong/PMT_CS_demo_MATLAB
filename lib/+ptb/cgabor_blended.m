function gabormat = cgabor_blended(varargin)
%CGABOR_BLENDED Generates a 3-layer matrix (RGB) containing a chromatic Gabor
%patch blended to the background color.
%
%   Example:
%      <a href="matlab:ptb.imshow_alpha(ptb.cgabor_blended(400, [], [], [], [], .01, [], 45, 25));">ptb.imshow_alpha(ptb.cgabor_blended(400, [], [], [], [], .01, [], 45, 25));</a>
%
%   See also CGABOR_ALPHA, GABOR_ALPHA, GABOR_BLENDED.

	rows    = pretina_arg(varargin, 1,  mfilename, 'rows',    [],                  {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	cols    = pretina_arg(varargin, 2,  mfilename, 'cols',    rows,                {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	bgcolor = pretina_arg(varargin, 5,  mfilename, 'bgcolor', [127.5 127.5 127.5], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan', 'size', [1 3]});

	if length(varargin) >= 4
		gabormat = ptb.cgabor_alpha(varargin{[1:4, 6:end]});
	else
		gabormat = ptb.cgabor_alpha(varargin{:});
	end
	gabormat(:, :, end) = gabormat(:, :, end) ./ 255;
	gabormat = apply_alpha( ...
		rgb2map(bgcolor, rows, cols), ...
		gabormat ...
		);
end