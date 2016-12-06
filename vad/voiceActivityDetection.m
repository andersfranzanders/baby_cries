function [calCs,support,realCs,xInWindows,spectogram,ceptogram] = voiceActivityDetection( x, classSignal, windowLengthInMS,Fs)


[support,M,xInWindows,spectogram,ceptogram] = windowAndExtractFeatures_reduced( x,classSignal,windowLengthInMS,Fs );
thresholdedCs = thresholdAllFeatures(M);
calCs = decisionSmoothing(thresholdedCs);
realCs = M(:,end)';

end

