function f = SimpleMsgScreen(text, text_params, fp_params, use_mouse, key_next)
	if ~exist('text_params', 'var') || isempty(text_params) text_params = {}; end %#ok<SEPEX>
	if ~exist('fp_params', 'var')   || isempty(fp_params)   fp_params = {};  end %#ok<SEPEX>
	if ~exist('use_mouse', 'var')   || isempty(use_mouse)   use_mouse = false; end %#ok<SEPEX>
	if ~exist('key_next', 'var')    || isempty(key_next)
		if use_mouse; key_next = MouseBtnDown('left'); else key_next = KbName('space'); end;
	end

	function MsgScreen(~, ~, ws)
		% text
		if ~isempty(text)
			if isempty(text_params) && isfield(ws, 'text_params')
				text_params = ws.text_params;
			end
			CenterText(ws.wptr, ws.rect, text, text_params{:});
		end
		% fixation point
		if isempty(fp_params) && isfield(ws, 'fp_params')
			fp_params = ws.fp_params;
		end
		if ~isempty(fp_params)
			SimpleFixation(ws.wptr, ws.rect, fp_params{:});
		end
		Screen('Flip', ws.wptr);
		% wait for key press
		if ~isfield(ws, 'auto_resp') || ~ws.auto_resp
			if use_mouse; expmouse(key_next); else expkey(key_next); end;
		end
	end
	f = @MsgScreen;
end