function cum_value = mat_sum(cell)
cum_value = zeros(size(cell{1}));
for i1 = 1:length(cell)
    
    cum_value = cum_value + cell{i1};
end
end