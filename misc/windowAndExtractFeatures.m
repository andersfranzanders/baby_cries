function [ support, featureMatrix] = windowAndExtractFeatures( x,classSignal,windowSizeInMs,Fs )

%cut Signal into overlapping Windows and calculate spectogram by STFT
xInWindows = cutSignalIntoWindows(x,windowSizeInMs,Fs);
xInWindows = xInWindows(1:end-1,:);
specto = calSpectogram(xInWindows, 2^11);
%ceptogram = calCeptogram(specto);

%calculate support vector for output signal of voice-detection-signals
[rows,cols] = size(xInWindows);
lengthOfOriginalSignal = rows*cols/2;
support = 1:(cols/2):lengthOfOriginalSignal;

% produce feature Matrix
featureMatrix = zeros(rows, 11);

%calculate Features
Es = calculateEnergies(xInWindows);
ents = calUnnormalizedSpectralEntropie(specto);
domfreqs = calMostDominantFrequency(specto,Fs);
ZCR = calculateZeroCrossingRate(xInWindows);
normSpecEntropies = calNormalizedSpectralEntropie(specto);
% [ cepMostDomPeak, cepNumPeaks, cepLocFirstPeak]  = calCeptralPeaks(ceptogram,Fs,100,800);
% [corMagPeak, corPeakCount] =  maximumAutocorrelationPeak( xInWindows, 50,600, Fs );

featureMatrix(:,1) = Es(:);
featureMatrix(:,2) = ZCR(:);
featureMatrix(:,3) = ents(:);
featureMatrix(:,4) = normSpecEntropies(:);
featureMatrix(:,5) = domfreqs(:);
% featureMatrix(:,6) = cepMostDomPeak;
% featureMatrix(:,7) = cepNumPeaks;
% featureMatrix(:,8) = cepLocFirstPeak;
% featureMatrix(:,9) = corMagPeak(:);
% featureMatrix(:,10) = corPeakCount(:);

%featureMatrix(:,11:end-1) = calMFCCgram( specto, 30, 13, 50, 10000, Fs );


%calculate Classes for every Frame
Cs = calculateClasses(xInWindows, classSignal);
featureMatrix(:,end) = Cs(:);


end

