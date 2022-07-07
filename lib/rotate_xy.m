function [rx, ry] = rotate_xy(varargin)
%ROTATE_XY Rotates maps of x- and y-values in the monitor coordinate.
%
%   [RX, RY] = ROTATE_XY(BX ,BY, TILT) returns matrices with the same size as BX
%   and BY, whose values are x- and y-values tilted by TILT degrees from the
%   given BX and BY, respectively.
%
%   Arguments:
%      BX   - matrix containing x-values.
%      BY   - matrix containing y-values.
%      TILT - tilt angle of the x- and y-axes, 90 if empty or not provided.
%
%   See also BASE_XY.

	bx   = pretina_arg(varargin, 1, mfilename, 'bx',   [], {'numeric'}, {'real', 'finite', 'nonnan'});
	by   = pretina_arg(varargin, 2, mfilename, 'by',   [], {'numeric'}, {'real', 'finite', 'nonnan', 'size', size(bx)});
	tilt = pretina_arg(varargin, 3, mfilename, 'tilt', 90, {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});

	rx = bx * cosd(tilt) + by * sind(tilt);
	if nargout > 1
		ry = bx * cosd(tilt + 90) + by * sind(tilt + 90);
	end
end