function [mat] = color_forDrawLines(angleMat)

rgb = Lab_ColorWheel(angleMat) * 255;
mat = reshape(repmat([rgb(:, :, 1), rgb(:, :, 2), rgb(:, :, 3)]', 2, 1), 3, []);




end