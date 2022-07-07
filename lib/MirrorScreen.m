function MirrorScreen(mode, wptr, rect)
	switch mode
		case 'set'
			[cx, cy] = RectCenter(rect);
			Screen('glPushMatrix', wptr);
			Screen('glTranslate', wptr, cx, cy, 0);
			Screen('glScale', wptr, -1, 1, 1);
			Screen('glTranslate', wptr, -cx, -cy, 0);
		case 'unset'
			Screen('glPopMatrix', wptr);
		otherwise
			MirrorScreen('set', wptr, rect);
	end
end