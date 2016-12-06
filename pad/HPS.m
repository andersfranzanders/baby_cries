function [ pitch ] = HPS( X,Fs,minFreq,maxFreq,R )

FFTSize = (length(X)-1)*2;
lowerBound = floor(minFreq*FFTSize/Fs);
upperBound = floor(maxFreq*FFTSize/Fs);
D = zeros(1,upperBound);


for i = lowerBound:upperBound
    p = 1;
    for r=1:R
        p = p*X(r*i);
    end
    D(i) = p;
end

[maxValue,pitch] = max(D);

%correct octave error
%halfpitch = 0.5*pitch
if  mod(0.5*pitch,2) == 0 ...
    && (X(0.5*pitch) < 0.6*X(pitch)) ...
    && (X(0.5*pitch) > 0.4*X(pitch)) ...
    && (X(0.5*pitch)/X(pitch)>1/R)

    pitch = 0.5*pitch;
end


pitch = pitch*Fs/FFTSize;


end

