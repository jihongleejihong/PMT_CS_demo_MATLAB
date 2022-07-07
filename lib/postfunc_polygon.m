function voidmap = postfunc_polygon(voidmap, params, mx, my)
%POSTFUNC_POLYGON Marks a polygon as occupied area in the VOIDMAP.
%
%   See also RANDOM_COORDS, DEMO_RANDOMCOORDS_POLYGONS.

	[radius, sides, tilt] = pretina_params(params, [], 3, 0);

	angles = linspace(0, 360, sides + 1);
	angles = angles(angles < 360) + tilt;
	[rows, cols] = size(mx);
	pixelmap = zeros(rows, cols, length(angles));
	for i = 1:length(angles)
		[~, pixelmap(:, :, i)] = rotate_xy(mx, my, angles(i));
	end
	voidmap = voidmap .* (1 - mk_shape(max(pixelmap, [], 3), radius));
end