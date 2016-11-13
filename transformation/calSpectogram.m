function [ specto ] = calSpectogram(windowedX, FFtLength)

[rows,cols] = size(windowedX);

if cols > FFtLength
    error('FFt-Length is to short!')
end

specto = zeros(rows,FFtLength/2 + 1);
hammingWindow = hamming(cols);
for i = 1:rows
    buffer = windowedX(i,:);
    windowedBuffer = buffer.*hammingWindow';
    Y = fft(windowedBuffer,FFtLength);
    specto(i,:) = abs(Y(1:(FFtLength/2 + 1)));
end

%displaySpecto(specto,0.6);

end

