function [ ents ] = calUnnormalizedSpectralEntropie( specto )

[rows,cols] = size(specto);
ents = zeros(1,rows);
for i =1:rows
    abs_fft = specto(i,:);
    px = (abs_fft);
    ents(i) = sum(px.*log(px));
end

end

