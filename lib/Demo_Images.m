%DEMO_IMAGES Shows examples on how to use image functions.
%
%   See <a href="matlab:edit Demo_Images;">source code</a> for details.

demo_rows = 5;
demo_cols = 4;

% map_linear, mk_grating, map_symmetric, mk_shape
subplot(demo_rows, demo_cols, 1);
imshow(normalize_map(map_linear(200, [], 30)));
subplot(demo_rows, demo_cols, 2);
imshow(mk_grating(map_linear(200, [], 30), 5/200));
subplot(demo_rows, demo_cols, 3);
imshow(normalize_map(map_symmetric(200, 300, -15)));
subplot(demo_rows, demo_cols, 4);
imshow(mk_shape(map_symmetric(200, 300, -15), 50));

% map_radial, mk_gaussian
subplot(demo_rows, demo_cols, 5);
imshow(normalize_map(map_radial(200)));
subplot(demo_rows, demo_cols, 6);
imshow(mk_gaussian(map_radial(200), 20));
subplot(demo_rows, demo_cols, 7);
imshow(mk_shape(map_radial(200, 300, 2, 15), 75));
subplot(demo_rows, demo_cols, 8);
imshow(mk_grating(map_radial(200, 300, 2, 15), 5/200));

% map_rectangular, mk_logistic
subplot(demo_rows, demo_cols, 9);
imshow(normalize_map(map_rectangular(200)));
subplot(demo_rows, demo_cols, 10);
imshow(mk_logistic(map_rectangular(200), 50, -.2));
subplot(demo_rows, demo_cols, 11);
imshow(mk_shape(map_rectangular(200, 300, 2, 15), 75));
subplot(demo_rows, demo_cols, 12);
imshow(mk_grating(map_rectangular(200, 300, 2, 15), 5/200));

% map_pivotal
subplot(demo_rows, demo_cols, 13);
imshow(normalize_map(map_pivotal(200)));
subplot(demo_rows, demo_cols, 14);
imshow(normalize_map(abs(map_pivotal(200) - 180)));
subplot(demo_rows, demo_cols, 15);
imshow(mk_shape(map_pivotal(200, 300, 180 - 45), 90));
subplot(demo_rows, demo_cols, 16);
imshow(mk_grating(map_pivotal(200, 300), 8/360));

% application (1): ring
subplot(demo_rows, demo_cols, 17);
ring_mat = mk_shape(map_radial(200), 90) ...
	.* (1 - mk_shape(map_radial(200), 70));
imshow(ring_mat);

% application (2): HSV color wheel
subplot(demo_rows, demo_cols, 18);
hsv_image = cat(3, map_pivotal(200) / 360, ring_mat, ring_mat);
imshow(hsv2rgb(hsv_image));

% application (3): elongated sine grating
grating_mat = mk_grating(map_linear(200, 300, 60), 5/200);
subplot(demo_rows, demo_cols, 19);
elongated_mask = mk_shape(map_radial(200, 300, 2, -30), 75);
imshow(apply_alpha(.5, grating_mat, elongated_mask));

% application (4): elongated Gabor
subplot(demo_rows, demo_cols, 20);
elongated_gaussian = mk_gaussian(map_radial(200, 300, 2, -30), 20);
imshow(apply_alpha(.5, grating_mat, elongated_gaussian));
