function [ support,xInWindows,specto,ceptogram] = windowAndTransform( x,windowSizeInMs,Fs )

%cut Signal into overlapping Windows and calculate spectogram by STFT
xInWindows = cutSignalIntoWindows(x,windowSizeInMs,Fs);
xInWindows = xInWindows(1:end-1,:);
specto = calSpectogram(xInWindows, 2^11);
ceptogram = calCeptogram(specto);

%calculate support vector for output signal of voice-detection-signals
[rows,cols] = size(xInWindows);
lengthOfOriginalSignal = rows*cols/2;
support = 1:(cols/2):lengthOfOriginalSignal;

end

