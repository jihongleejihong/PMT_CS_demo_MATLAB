function resp = PMT_BtnDown(x, y, btns, ap, ws)
resp = [];

coord_range = linspace(ws.bar_rect(1), ws.bar_rect(3), 100);

[x_dist, closestIndex] = min(abs(coord_range - x));
y_dist = abs((ws.bar_rect(4) + ws.bar_rect(2)) ./2 - y);

% closestCoords = choicecoords(closestIndex, :);


if btns(1) == 1
        
        if  x_dist <=  1 * ap.pxpd && y_dist <=  1 * ap.pxpd
            resp = closestIndex;
        end
        
    end

end