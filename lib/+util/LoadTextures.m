function [textures, n] = LoadTextures(wptr, path, filter)
	if ~exist('filter', 'var') || isempty(filter)
		filter = '.*\.(bmp|gif|jpe?g|png|tiff?)$';
	end

	textures = [];
	files = dir(path);
	for i = 1:length(files)
		file = files(i);
		if ~file.isdir && ~isempty(regexp(file.name, filter, 'once'))
			image = imread2(fullfile(path, file.name));
			textures(end + 1) = Screen('MakeTexture', wptr, image); %#ok<AGROW>
		end
	end
	n = length(textures);
end