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
halfpitch = floor(0.5*pitch);

if halfpitch == 0
   debuggi = 0;
end
% if  mod(v,2) == 0 ...
%     && (X(halfpitch) < 0.6*X(pitch)) ...
%     && (X(halfpitch) > 0.4*X(pitch)) ...
%     && (X(halfpitch)/X(pitch)>1/R)
% 
%     pitch = 0.5*pitch;
% end

if  (X(halfpitch) < 0.6*X(pitch)) ...
    && (X(halfpitch) > 0.4*X(pitch)) ...
    && (X(halfpitch)/X(pitch)>1/R)

    pitch = 0.5*pitch;
end

pitch = pitch*Fs/FFTSize;


end

