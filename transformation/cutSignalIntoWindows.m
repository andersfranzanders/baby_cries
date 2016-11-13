function [ xInWindows ] = cutSignalIntoWindows(x, windowLengthInMs,Fs)

%Convert Window Size in millisenconds to samplecount
windowLength = floor(Fs*0.001*windowLengthInMs);
if mod(windowLength,2) == 1
    windowLength = windowLength - 1;
end

%pad Zeroes to end of signal so the last window gets enough samples
hopsize = windowLength/2;
zerosToAdd = zeros((windowLength - mod(length(x), windowLength)) + hopsize,1);
x = cat(1,x,zerosToAdd);

%preallocate output matrix
numOfWindows = 2*(length(x)-hopsize)/windowLength;
xInWindows = zeros(numOfWindows,windowLength);

%cut signal into chunks and put them into the ouput matrix
for i = 1:numOfWindows
    start = (i-1)*hopsize+1;
    buffer = x(start:start+windowLength-1);
    xInWindows(i,:) = buffer(:); 
end

end

