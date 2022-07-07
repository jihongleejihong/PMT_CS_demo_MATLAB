function [mat] = mk_color_mat(angleMat, labmat, rad)

rgb = Lab_ColorWheel(angleMat, labmat, rad) * 255;
mat = [rgb(:, :, 1), rgb(:, :, 2), rgb(:, :, 3)]';




end