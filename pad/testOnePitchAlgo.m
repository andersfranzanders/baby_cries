function [ pitches] = testOnePitchAlgo( xInWindows,Cs,Fs,minFreq,maxFreq,ceptogram,specto)

[rows,cols] = size(xInWindows);

pitches = zeros(1,rows);


for i = 1:rows
    
    if Cs(i) > 0.5
        x = xInWindows(i,:);
        cepstrum = ceptogram(i,:);
        X = specto(i,:);
        
        %pitches(i) = acorr_MPM_maxPeak( x,Fs,minFreq,maxFreq);
        pitches(i) = acorr_nACF_maxPeak( x,Fs,minFreq,maxFreq);
    end
    
end



end



