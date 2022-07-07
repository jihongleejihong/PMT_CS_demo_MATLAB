function duration_check = aperture_noise_adaptor(ws, ap, duration)
  noisepattern = ws.noisepattern;
  rectSize = ws.adapt_area;
  num_patches = ap.FrameRate * duration;
  % making noise patches 
  for i = 1 : num_patches
      noise_unit = (50*randn(ws.grain_reps, ws.grain_reps) + 127);
      noiseimg = noise_unit(noisepattern);
      noise_frame(i) = Screen('MakeTexture', ws.wptr, noiseimg);
end
  

try
        ifi = Screen('GetFlipInterval', ws.wptr);
        objRect = SetRect(0,0, rectSize, rectSize);
        dstRect = ArrangeRects(1, objRect, ws.rect);
        
             [cx, cy] = RectCenter(dstRect(1,:));
             dstRect(1,:)=CenterRectOnPoint(objRect, cx, cy);
        

aperture=Screen('OpenOffscreenwindow', ws.wptr, 127, objRect);
   Screen('FillOval', aperture, [255 255 255 0], objRect);
     Screen('FrameOval', aperture, [127 127 127 255], objRect);
       Screen('BlendFunction', ws.wptr, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
       
        count = 1;
    
        % Perform initial Flip and sync us to the retrace:
    vbl = Screen('Flip', ws.wptr);

    % Record time of start of presentation loop:
    tstart = vbl;
while count <= num_patches
     Screen('DrawTexture', ws.wptr, noise_frame(count), [], dstRect(1,:), [], 0);
     DrawCrosshair(ws.wptr, ws.rect, ws.crosshair{:});
     Screen('DrawTexture', ws.wptr, aperture, [], dstRect(1,:), [], 0);
     Screen('Close', noise_frame(count));
     vbl = Screen('Flip', ws.wptr);
	if count == 1
	 adapterImage = Screen('GetImage', ws.wptr, ws.rect);
	imwrite(adapterImage, 'adapterImage.jpg');
	end
     count = count + 1;
end
    duration_check = vbl - tstart;
    telapsed = GetSecs - tstart;
    updaterate = count / telapsed;
catch
    % Our usual error handler: Close screen and then...
    Screen('CloseAll');
    % ... rethrow the error.
    psychrethrow(psychlasterror);
end