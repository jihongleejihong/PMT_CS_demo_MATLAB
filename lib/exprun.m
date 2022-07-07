function [mat, ws, e] = exprun(seq, mat, ws, varargin)
	% validate arguments
	[rows, cols] = size(mat);
	assert(size(seq, 1) == 1, 'exp. sequence (1st arg.) should be a 1-by-n vector');
	assert(rows > 0 && cols > 0, 'exp. matrix (2nd arg.) should be a m-by-n matrix');
	assert(rows == size(seq, 2), 'number of rows of exp. matrix (2nd arg.) should be equal to the length of exp. sequence (1st arg.)');

	% experimental loop
	conds = mat(:, 2:end);
	try
		for n = 1:length(seq)
			rmat = [];
			for argin = varargin
				f = fwrap(argin{:});
				[r, ws] = f(n, conds(seq(n), :), ws);
				rmat = [rmat, r]; %#ok<AGROW>
			end
			if ~isempty(rmat)
				mat(seq(n), cols + (1:size(rmat, 2))) = rmat;
			end
		end
		e = [];
	catch e
		if ~isfield(ws, 'rethrow') || ~ws.rethrow
			rethrow(e);
		end
	end
end