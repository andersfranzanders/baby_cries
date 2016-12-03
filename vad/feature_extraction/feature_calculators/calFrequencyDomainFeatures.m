function [ unnormSpecEntsFeats, normSpecEntsFeats, domFreqFeats ] = calFrequencyDomainFeatures( specto, Fs,lowerHz, upperHz )

[rows,cols] = size(specto);
unnormSpecEntsFeats = zeros(1,rows);
normSpecEntsFeats = zeros(1,rows);
domFreqFeats = zeros(1,rows);


FFTSize = (cols-1)*2;
lowerBound = floor(lowerHz*FFTSize/Fs);
upperBound = floor(upperHz*FFTSize/Fs);

for i =1:rows
    abs_fft = specto(i,lowerBound:upperBound);
    
    unnormSpecEntsFeats(i) = sum(abs_fft .*log(abs_fft ));
    
    px = (abs_fft)/sum(abs_fft);
    normSpecEntsFeats(i) = sum(px.*log(px));
    
    [max_value,index] = max(specto(i,:));
    domFreqFeats(i) = index * (Fs/FFTSize);
end

end

