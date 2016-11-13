function [Es_thresholded] = thresholdEsAdaptive(Es,x)

rms = sqrt(mean(x.^2));
threshold = rms^2;

Es_thresholded = zeros(size(Es));

for i = 1:length(Es)
    if Es(i) > threshold
        Es_thresholded(i) = 0.8;
    else
        Es_thresholded(i) = 0;
    end
end



end

