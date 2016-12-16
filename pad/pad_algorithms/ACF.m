function [ pitch ] = ACF( x,Fs,minFreq,maxFreq )

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);

acf = autocorr(x,minLag);
acf = acf(maxLag:end);
[pks,locs,w,p] = findpeaks(acf);

if isempty(pks)
    pks = 0;
    location = 0;
else
    [maxvalue, maxindex] = max(pks);
    location = locs(maxindex)+maxLag-1;
end
pitch = Fs/location;



end

