function SimpleTextScreen(text, ws)
	if isfield(ws, 'Crosshair_Default')
		SimpleCrosshair(ws.wptr, ws.Crosshair_Default);
	end
	if isfield(ws, 'Fixation_Default')
		SimpleFixation(ws.wptr, ws.Fixation_Default);
	end

	text_color = [0 0 0];
	if isfield(ws, 'SimpleText_Color')
		text_color = ws.SimpleText_Color;
	end
	text_offset = [0 0];
	if isfield(ws, 'SimpleText_Offset')
		text_offset = ws.SimpleText_Offset;
	end

	SimpleText(ws.wptr, ws.rect, text, text_color, text_offset);
	Screen('Flip', ws.wptr);
	if ~isfield(ws, 'AutoPilot') || ~ws.AutoPilot
	    WaitSecs(.2);
		expkey(KbName('space'));
	end
end