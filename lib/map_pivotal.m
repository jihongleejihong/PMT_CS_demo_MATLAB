function pixelmap = map_pivotal(varargin)
%MAP_PIVOTAL Generates a map of angles measured from the vertical meridian.
%
%   PIXELMAP = MAP_PIVOTAL(ROWS [,COLS] [,PHASE]) returns a ROWS-by-COLS matrix,
%   whose value is an angle measured from the reference axis tilted by PHASE
%   degrees from the vertical meridian.
%
%   Arguments:
%      ROWS  - number of rows of the output matrix.
%      COLS  - number of columns, the same as ROWS if empty or not provided.
%      PHASE - tilt angle of the reference axis measured from the vertical
%         meridian. If empty or not provided, the vertical meridian is used as
%         the reference axis.
%
%   Example:
%       <a href="matlab:imshow(map_pivotal(200, [], 45) / 360);">imshow(map_pivotal(200, [], 45) / 360);</a>

	rows  = pretina_arg(varargin, 1, mfilename, 'rows',  [],    {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	cols  = pretina_arg(varargin, 2, mfilename, 'cols',  rows,  {'numeric'}, {'scalar', 'integer', 'finite', 'positive'});
	phase = pretina_arg(varargin, 3, mfilename, 'phase', 0,     {'numeric'}, {'scalar', 'real', 'finite', 'nonnan'});

	[bx, by] = base_xy(cols, rows, phase);
	pixelmap = xy2angle(bx, by);
end