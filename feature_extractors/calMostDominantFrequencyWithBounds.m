function [ domfreqs ] = calMostDominantFrequencyWithBounds( spectogram, lowerHz, upperHz , Fs )

[rows,cols] = size(spectogram);
FFtsize = (cols-1)*2;
lowerBound = floor(lowerHz*FFtsize/Fs);
upperBound = floor(upperHz*FFtsize/Fs);
domfreqs = zeros(1,rows);
for i = 1:rows
    [max_value,index] = max(spectogram(i,lowerBound:upperBound));
    %%domfreqs(i) = 10*index/cols;
    domfreqs(i) = index * (Fs/FFtsize);
end

