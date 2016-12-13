function [ pitch ] = DomFreq( X,Fs )

FFTSize = (length(X)-1)*2;

%[max_value,index] = max(X);
[pks,locs,w,p] = findpeaks(X);
[maximum,index] = max(p);
location = locs(index);
 pitch = location * (Fs/FFTSize);

end

