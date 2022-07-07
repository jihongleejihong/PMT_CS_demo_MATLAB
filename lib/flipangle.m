function deg = flipangle(deg)
	deg = mod(deg + 180, 360) - 180;
end