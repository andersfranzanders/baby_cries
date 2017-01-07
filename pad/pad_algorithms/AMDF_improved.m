function [ pitch ] = AMDF_improved( x,Fs,minFreq,maxFreq )

minLag = floor(Fs/minFreq);
maxLag = floor(Fs/maxFreq);
pitch = 0;

r = zeros(1,minLag);
for i = 1:minLag
    x_j = x(1:minLag-i+1);
    x_jr = x(i:minLag);
    r(i) = 1/(minLag-i+1) * sum ( abs(x_j - x_jr) );
end

[minValue,minIndex] = min(r(maxLag:minLag));

if ~isempty(r)
    minIndex = minIndex + maxLag;
    pitch = Fs/minIndex;
end

end

