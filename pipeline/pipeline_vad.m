function [calCs,support,realCs,xInWindows,spectogram,ceptogram] = pipeline_vad( x, classSignal, windowLengthInMS,Fs)


[support,M,xInWindows,spectogram,ceptogram] = windowAndExtractFeatures_reduced( x,classSignal,windowLengthInMS,Fs );
thresholdedCs = thresholdFeatures_CeD_002(M);
calCs = decisionSmoothing(thresholdedCs);
realCs = M(:,end)';

end

