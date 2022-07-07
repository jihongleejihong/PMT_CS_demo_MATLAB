function diam_set = cvt_psy2phy_area(psy_set)

phy_area = psy_set.^(1/0.76);

phy_rad = sqrt(phy_area ./ pi);



diam_set = phy_rad .* 2;




end

