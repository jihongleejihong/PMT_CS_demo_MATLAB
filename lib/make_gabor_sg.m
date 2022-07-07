function make_gabor_sg(wptr, rect, pxpd)

% 	if exist('rng', 'file') == 2
% 		rng('shuffle');
% 	else
% 		rand('seed', GetSecs); %#ok<RAND>
% 	end
% pxpd = 42;
% Screen('Preference', 'SkipSyncTests', 1);
% 	[wptr, rect] = Screen('OpenWindow', 0, [127, 127, 127]);
% 	Screen('BlendFunction', wptr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
% 	Screen('HideCursorHelper', wptr);
	[cx, cy] = RectCenter(rect);

	tex_size  = 400;
	l_gabor   = 127;
	c_gabor   = [];
	f_gabor   = 1 / 8;	% 1 cycle / 5 deg
	sd_gabor  = 5;		% 5 px
	stim_sg = ptb.gabor_alpha( ...
		tex_size, [], ...
		l_gabor, ...	% mean luminance
		c_gabor, ...	% contrast
		f_gabor, ...	% spatial freq.
		90, ...			% phase (sine grating)
		0, ...			% tilt angle (sine grating)
		sd_gabor ...	% std. dev
		);
	gtex = Screen('MakeTexture', wptr, stim_sg);

    gabor_angle = distnorm(rand(1, 15), 0, 15);	
	Screen('DrawTexture', wptr, gtex,[], [], gabor_angle(Randi(15)));
	Screen('Flip', wptr);
  
% 	expkey(KbName('space'));
% 	Screen('CloseAll');
end