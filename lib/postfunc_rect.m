function voidmap = postfunc_rect(voidmap, params, mx, my)
%POSTFUNC_RECT Marks a rectangle as occupied area in the VOIDMAP.
%
%   See also RANDOM_COORDS, DEMO_RANDOMCOORDS_RECTS.

	[radius, ratio, tilt] = pretina_params(params, [], 1, 0);

	[bx, by] = rotate_xy(mx, my, tilt);
	voidmap = voidmap .* (1 - mk_shape(max(abs(bx), abs(by) * ratio), radius));
end