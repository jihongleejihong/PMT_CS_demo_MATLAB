function pixelmap = map_symmetric(varargin)
%MAP_SYMMETRIC Symmetric equivalent of MAP_LINEAR.
%
%   PIXELMAP = MAP_SYMMETRIC(ROWS [,COLS] [,TILT]) returns a ROWS-by-COLS
%   matrix, whose value increases as its location moves away from the center
%   of the x-axis tilted by TILT degrees.
%
%   Arguments:
%      ROWS - number of rows of the output matrix.
%      COLS - number of columns, the same as ROWS if empty or not provided.
%      TILT - tilt angle of the x-axis, 0 if empty or not provided.
%
%   See also MAP_LINEAR.

	rows = pretina_arg(varargin, 1, mfilename, 'rows', [],   {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	cols = pretina_arg(varargin, 2, mfilename, 'cols', rows, {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	tilt = pretina_arg(varargin, 3, mfilename, 'tilt', 0,    {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});

	pixelmap = abs(base_xy(cols, rows, tilt));
end