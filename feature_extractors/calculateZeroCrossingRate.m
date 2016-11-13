function ZCRout = calculateZeroCrossingRate(xInWindows)

[rows, cols] = size(xInWindows);
ZCRout = zeros(1,rows);
for i = 1:rows
    window = xInWindows(i,:);
    crossings = 0;
    for j = 1:length(window)-1
        if (window(j) > 0 && window(j+1) < 0 ) || (window(j) < 0 && window(j+1) > 0 )
            crossings = crossings+1;
        end
    end
    crossings = crossings/length(window);
    ZCRout(i) = crossings;
end


end

