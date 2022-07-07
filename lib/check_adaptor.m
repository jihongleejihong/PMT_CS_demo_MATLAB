function check_adaptor(wptr, pxpd, adapt_duration)
grain_size = 0.2 * pxpd;
adaptor_size = 5 * pxpd;  
ifi = Screen('GetFlipInterval', wptr);
adapt_frame = round(adapt_duration / ifi);


% Time we want to wait before reversing the contrast of the checkerboard
% checkFlipTimeSecs = 0.2;
% checkFlipTimeFrames = round(checkFlipTimeSecs / ifi);
checkFlipTimeFrames = 5; %5Hz
frameCounter = 0;
frameCounter2 = 0;


% Time to wait in frames for a flip
waitframes = 1;

grain_unit = mkshape(map_rectangular(round(grain_size)));
white = 255 .* grain_unit;
black = 0 .* grain_unit;
patt_unit = [black, white; white, black];
check = repmat(patt_unit, adaptor_size/grain_size);
count_check = 255 - check;

checker(1) = Screen('MakeTexture', wptr, check);
checker(2) = Screen('MakeTexture', wptr, count_check);

% Texture cue that determines which texture we will show
textureCue = [1 2];

% Sync us to the vertical retrace
vbl = Screen('Flip', wptr);

while frameCounter2 < adapt_frame 

    % Increment the counter
    frameCounter = frameCounter + 1;
    frameCounter2 = frameCounter2 +1;
    % Draw our texture to the screen
    Screen('DrawTexture', wptr, checker(textureCue(1)));

    % Flip to the screen
    vbl = Screen('Flip', wptr, vbl + (waitframes - 0.5) * ifi);

    % Reverse the texture cue to show the other polarity if the time is up
    if frameCounter  == checkFlipTimeFrames
        textureCue = fliplr(textureCue);
        frameCounter = 0;
            end
            
end
    
    
end