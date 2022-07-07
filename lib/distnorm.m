function mat = distnorm(mat, m, sd)
	if ~exist('m',	'var') || isempty(m)  m = mean(mat(:)); end %#ok<SEPEX>
	if ~exist('sd', 'var') || isempty(sd) sd = std(mat(:)); end %#ok<SEPEX>

	mat = (mat - mean(mat(:))) / std(mat(:));
	mat = m + sd * mat;
end