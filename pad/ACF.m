function [ pitch ] = ACF( x,Fs,minFreq,maxFreq )

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);

acf = autocorr(x,minLag);
acf = acf(maxLag:end);
[pks,locs,w,p] = findpeaks(acf);

if isempty(pks)
    pks = 0;
end 
[maxvalue, maxindex] = max(pks);
location = locs(maxindex)+maxLag;

pitch = Fs/location;



end

