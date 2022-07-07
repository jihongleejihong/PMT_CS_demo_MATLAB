function gratingmat = grating_blended(varargin)
%GRATING_BLENDED Generates a matrix containing a grayscale sinusoidal grating
%blended to the background luminance.
%
%   Example:
%      <a href="matlab:ptb.imshow_alpha(ptb.grating_blended(400, [], [], [], .01, [], 45, 120));">ptb.imshow_alpha(ptb.grating_blended(400, [], [], [], .01, [], 45, 120));</a>
%
%   See also GRATING_ALPHA, CGRATING_ALPHA, CGRATING_BLENDED.

	bg_lum = pretina_arg(varargin, 3,  mfilename, 'bg_lum', 127.5, {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});

	gratingmat = ptb.grating_alpha(varargin{:});
	gratingmat(:, :, end) = gratingmat(:, :, end) ./ 255;
	gratingmat = apply_alpha(bg_lum, gratingmat);
end