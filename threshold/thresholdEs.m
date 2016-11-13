function [ support, Es_thresholded] = thresholdEs( support, Es, threshold )

Es_thresholded = zeros(size(Es));

for i = 1:length(Es)
    if Es(i) > threshold
        Es_thresholded(i) = 0.8;
    else
        Es_thresholded(i) = 0;
    end
end



end

