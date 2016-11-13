function [ support, EDetect, VDetect ] = voiceActivityDetection(x,Fs,windowsSizeInMs)

%cut Signal into overlapping Windows and calculate spectogram by STFT
xInWindows = cutSignalIntoWindows(x,windowsSizeInMs,Fs);
specto = calSpectogram(xInWindows, 2^11);

%calculate support vector for output signal of voice-detection-signals
[rows,cols] = size(xInWindows);
lengthOfOriginalSignal = rows*cols/2;
support = 1:(cols/2):lengthOfOriginalSignal;

%calculate voice detection by energy of windows
Es = calculateEnergies(xInWindows);
EDetect = thresholdEsAdaptive(Es,x);

%calculate features by most dominant frequency and entropy of each
%frame
domfreqs = calMostDominantFrequencies( specto );
ents = calEntropie(specto);

%threshold voice features
[support,VDetect] = thresholdSpectoFeatures(support,ents, EDetect, domfreqs);

end

