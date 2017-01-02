function [ pitch,clarity ] = acorr_nACF_maxPeak( x,Fs,minFreq,maxFreq )

% Attention: Best Threshold found at k = 0.86

pitch = 0;
clarity = 1;

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);

r = zeros(1,minLag);
for i = 1:minLag
    x_j = x(1:minLag-i+1);
    x_jr = x(i:minLag);
    r(i) = sum ( x_j.*x_jr ) / ( sqrt(sum(x_j.^2) * sum(x_jr.^2)));
end

n = r;

[pks,locs] = findpeaks(n);

if ~isempty(pks)
    [maxvalue, maxindex] = max(pks);
    location = locs(maxindex)+maxLag-1;
    pitch = Fs/location;
end

end

