function [xy] = xy_forDrawLines(angleMat, lengthMat, coords)
[x, y] = angle2xy(angleMat);
hx = x ./ 2;
hy = y ./ 2;



x = [zeros(size(x)), (lengthMat .* x)]' + coords(1, :) - (lengthMat .* hx)';
y = [zeros(size(y)), (lengthMat .* y)]' + coords(2, :) - (lengthMat .* hy)';

xy = [x(:), y(:)]';
end