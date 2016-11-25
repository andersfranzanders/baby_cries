function [ ents ] = calUnnormalizedSpectralEntropyWithBounds( specto, lowerHz, upperHz , Fs )



[rows,cols] = size(specto);
FFtSize = (cols-1)*2;
lowerBound = floor(lowerHz*FFtSize/Fs);
upperBound = floor(upperHz*FFtSize/Fs);

ents = zeros(1,rows);
for i =1:rows
    abs_fft = specto(i,lowerBound:upperBound);
    px = (abs_fft);
    ents(i) = sum(px.*log(px));
end



end

