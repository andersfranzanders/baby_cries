function [ flatness ] = calSpectralFlatnessWithBounds( specto,lowerHz, upperHz , Fs )
[rows,cols] = size(specto);
flatness = zeros(1,rows);
FFtSize = (cols-1)*2;
lowerBound = floor(lowerHz*FFtSize/Fs);
upperBound = floor(upperHz*FFtSize/Fs);

for i =1:rows
    abs_fft_in = specto(i,:);
    abs_fft = abs_fft_in(lowerBound:upperBound);
    flatness(i) = 10*log10(mean(abs_fft)/geomean(abs_fft));
end

end

