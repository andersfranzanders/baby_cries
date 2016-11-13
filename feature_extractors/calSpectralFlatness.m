function [ flatness ] = calSpectralFlatness( specto )
[rows,cols] = size(specto);
flatness = zeros(1,rows);
for i =1:rows
    abs_fft = specto(i,:);
    flatness(i) = 10*log10(mean(abs_fft)/geomean(abs_fft));
end

end

