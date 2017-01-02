function [ pitch, clarity ] = acorr_MPM_maxPeak( x,Fs,minFreq,maxFreq)

% Attention: Best Threshold found at k = 0.86

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);
pitch = 0;
clarity = 0;

%cal autocorrelation
r = zeros(1,minLag);
for i = 1:minLag
    x_j = x(1:minLag-i+1);
    x_jr = x(i:minLag);
    r(i) = sum ( x_j.*x_jr );
end

%cal SDF-type III
m = zeros(1,minLag);
for i =1:minLag
    x_j = x(1:minLag-i+1);
    x_jr = x(i:minLag);
    m(i) = sum(x_j.^2 + x_jr.^2);
end


n = (2*r)./m;


[pks,locs] = findpeaks(n);

if ~isempty(pks)

    [maxvalue, maxindex] = max(pks);
    location = locs(maxindex)+maxLag-1;
    pitch = Fs/location;
end

end