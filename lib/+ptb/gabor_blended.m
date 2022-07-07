function gabormat = gabor_blended(varargin)
%GABOR_BLENDED Generates a matrix containing a Gabor patch blended to the
%background luminance.
%
%   Example:
%      <a href="matlab:ptb.imshow_alpha(ptb.gabor_blended(400, [], [], [], .01, [], 45, 25));">ptb.imshow_alpha(ptb.gabor_blended(400, [], [], [], .01, [], 45, 25));</a>
%
%   See also GABOR_ALPHA, CGABOR_ALPHA, CGABOR_BLENDED.

	bg_lum = pretina_arg(varargin, 3,  mfilename, 'bg_lum', 127.5, {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});

	gabormat = ptb.gabor_alpha(varargin{:});
	gabormat(:, :, end) = gabormat(:, :, end) ./ 255;
	gabormat = apply_alpha(bg_lum, gabormat);
end