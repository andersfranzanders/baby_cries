function [ pitch ] = ACF( x,Fs,minFreq,maxFreq )

pitch = 0;

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);

acf = autocorr(x,minLag);
acf = acf(maxLag:end);
[pks,locs,w,p] = findpeaks(acf);

if ~isempty(pks)

    [maxvalue, maxindex] = max(pks);
    location = locs(maxindex)+maxLag-1;
    pitch = Fs/location;
end



end

