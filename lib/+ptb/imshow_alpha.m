function imshow_alpha(varargin)
%IMSHOW_ALPHA Wraps a MATLAB function IMSHOW and shows an image matrix with an
%alpha layer (the last layer of a 2- or 4-layer matrix). If the given image has
%an alpha layer, image layer(s) will be blended to a uniform gray background.
%Arguments are the same as IMSHOW.
%
%   See also IMSHOW.

	IMG = pretina_arg(varargin, 1, mfilename, 'IMG', [], {'numeric'}, {'nonempty', 'real', 'finite', 'nonnan'});

	n_layers = size(IMG, 3);
	if any(n_layers == [2, 4])
		img_layers = 1:(n_layers - 1);
		a_layer    = n_layers;
	else
		img_layers = 1:n_layers;
		a_layer = [];
	end

	img_max = 1;
	img_min = 0;
	if isinteger(IMG)
		IMG = double(IMG);
		img_max = 255;
	elseif any(IMG(:) > 1)
		img_max = 255;
	end
	if any(IMG(:) < 0)
		img_min = -img_max;
	end
	img_mat = (IMG(:, :, img_layers) - img_min) ./ (img_max - img_min);
	if ~isempty(a_layer)
		img_mat = apply_alpha(.5, img_mat, IMG(:, :, a_layer) ./ img_max);
	end
	imshow(img_mat, varargin{2:end});
end