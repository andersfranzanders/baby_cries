function [ pitch ] = AMDF_old( x,Fs,minFreq,maxFreq )

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);
N = length(x);
D = zeros(1,N);
for t = 1:N
    D(t) = (1/(N-t))*sum(abs(x(1:N-t)-x(t+1:N)));
end

[minValue,minIndex] = min(D(maxLag:minLag));

if isempty(D)
    minIndex = 0;
end
minIndex = minIndex + maxLag;

pitch = Fs/minIndex;
end

