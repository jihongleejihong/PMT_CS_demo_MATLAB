% ceil((1:12) / 4);
% [mx, my] = meshgrid(ceil((1:12) / 4))
% (my - 1) * 3 + mx

[mx, my] = meshgrid(ceil((1: ws.adapt_area) / ws.grain_size));
a = (my - 1) * ceil(ws.grain_reps) + mx
