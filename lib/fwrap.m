function f = fwrap(func, test)
	assert(isa(func, 'function_handle'), 'exp. function (1st arg.) should be a function handle');
	if ~exist('test', 'var') || isempty(test)
		if strcmp(func2str(func), 'fwrap/wrapper')
			f = func;
			return;
		else
			test = @(~, ~, ~) true;
		end
	end
	assert(isa(func, 'function_handle'), 'test function (2nd arg.) should be a function handle, or an empty variable');
	
	function [r, ws] = wrapper(n, cond, ws)
		r = [];
		if test(n, cond, ws)
			argout = nargout(func);
			if (argout >= 1)
				if (argout == 1)
					r = func(n, cond, ws);
				else
					[r, ws] = func(n, cond, ws);
				end
				assert(size(r, 1) <= 1, '1st output arg. of exp. function should be a 1-by-n vector, or an empty variable');
			else
				func(n, cond, ws);
			end
		end
	end
	f = @wrapper;
end