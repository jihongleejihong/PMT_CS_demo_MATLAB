function [coords, voidmap, n] = random_coords(varargin)
%RANDOM_COORDS Places given shapes on random locations.
%
%   [COORDS, VOIDMAP, N] = RANDOM_COORDS(MASK, PARAMS [,POSTFUNC] [,PREFUNC])
%   returns a 2-column matrix containing the center coordinates of shapes
%   (COORDS), a matrix with the the same size as MASK representing unoccupied
%   area after the placements (VOIDMAP), and the number of successfully placed
%   shapes (N). This function tries to place given shapes to the area marked
%   with 1 in MASK. If some of the shapes cannnot be placed, their coordinates
%   will be [0, 0] in COORDS. The starting point of the coordinates is the
%   center of the MASK.
%
%   Arguments:
%      MASK     - an area mask. Shapes will be placed in area marked with 1.
%      PARAMS   - shape parameters, each row of which will be used as the second
%         argument of the PREFUNC and POSTFUNC.
%      POSTFUNC - a function handle. This function marks occupied area to the
%         VOIDMAP after placing each shape.
%      PREFUNC  - a function handle. This function adds margins around the
%         occupied area in the VOIDMAP before placing each shape.
%
%   See also DEMO_RANDOMCOORDS_GAUSSIAN, DEMO_RANDOMCOORDS_CIRCLES,
%   DEMO_RANDOMCOORDS_RECTS.

	mask     = pretina_arg(varargin, 1, mfilename, 'mask',     [],        {'numeric'},           {'nonempty', 'real', 'finite', 'nonnan', '2d'});
	params   = pretina_arg(varargin, 2, mfilename, 'params',   [],        {'numeric', 'struct'}, {'nonempty', '2d'});
	postfunc = pretina_arg(varargin, 3, mfilename, 'postfunc', [],        {'function_handle'},   { });
	prefunc  = pretina_arg(varargin, 4, mfilename, 'prefunc',  @(m, p) m, {'function_handle'},   { });

	n_coords = size(params, 1);
	[mask_h, mask_w] = size(mask);
	[bx, by] = base_xy(mask_w, mask_h);

	voidmap = ones(mask_h, mask_w);
	coords = zeros(n_coords, 2);
	n = 0;

	seedmat = rand(mask_h, mask_w);
	for i = 1:n_coords
		tmpseed = seedmat .* prefunc(voidmap .* mask, params(i, :));
		if max(tmpseed(:)) == 0
			break;
		end
		[~, xx] = max(max(tmpseed, [], 1));
		[~, yy] = max(max(tmpseed, [], 2));
		coords(i, :) = [bx(yy, xx), by(yy, xx)];
		voidmap = postfunc(voidmap, params(i, :), ...
			bx - coords(i, 1), by - coords(i, 2) ...
			);
		n = i;
	end
end