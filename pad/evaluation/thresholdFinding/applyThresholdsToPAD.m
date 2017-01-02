function [ pitchMatrix ] = applyThresholdsToPAD( xInWindows,Cs,thresholds,Fs,minFreq,maxFreq )

pitchMatrix = zeros(length(thresholds),length(Cs));

for i = 1:length(thresholds);
    k = thresholds(i)
    thesePitches = zeros(1,length(Cs));
    for frameNum=1:length(Cs)
        if Cs(frameNum) > 0.5
            x = xInWindows(frameNum,:);
            %thesePitches(frameNum) = acorr_MPM_mpmPeak( x,Fs,minFreq,maxFreq,k );
            %thesePitches(frameNum) = acorr_nACF_mpmPeak( x,Fs,minFreq,maxFreq,k );
            thesePitches(frameNum) = acorr_ACF_mpmPeak( x,Fs,minFreq,maxFreq,k );
        end
    end
    pitchMatrix(i,:) = thesePitches;
end


end

