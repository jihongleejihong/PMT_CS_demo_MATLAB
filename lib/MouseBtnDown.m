function f = MouseBtnDown(varargin)
	btns = zeros(1, 3);
	for argin = varargin
		switch argin{:}
			case 'left'
				btns(1) = 1;
			case 'scroll'
				btns(2) = 1;
			case 'right'
				btns(3) = 1;
		end
	end

	function resp = BtnDown(~, ~, b)
		switch length(b)
			case 1
				b = [b, 0, 0];
			case 2
				b = [b(1), 0, b(2)];
			otherwise
				b = b(1:3);
		end
		resp = find(b == btns);
	end
	f = @BtnDown;
end