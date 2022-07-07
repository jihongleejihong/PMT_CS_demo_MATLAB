function image = imread2(file)
	[image, ~, alpha] = imread(file);
	if size(image, 1) == size(alpha, 1) && size(image, 2) == size(alpha, 2)
		image(:, :, end + 1) = alpha;
	end
end