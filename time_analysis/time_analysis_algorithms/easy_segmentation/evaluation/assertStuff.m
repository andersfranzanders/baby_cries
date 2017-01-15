function [] = assertStuff( originalSegmentsMetaData, burstLengths, cryLengths, pauseLengths, energies,durations )

allFine = 1;
eTime=0.0125;
ePerc = 0.1;

[z,numOriginalSegments] = size(originalSegmentsMetaData);
[z,numFoundSegments] = size(burstLengths);

if numOriginalSegments ~= numFoundSegments
   error ('the chosen pause-Length for segmentation was to short!'); 
end

for i=1:numOriginalSegments
   originalDuration = originalSegmentsMetaData(1,i);
   originalBurstLength = originalSegmentsMetaData(2,i);
   originalBurstVariance = originalSegmentsMetaData(3,i);
   originalVoicedRatio = originalSegmentsMetaData(4,i);
   
   calculatedDuration = durations(i);
   calculatedBurstLength = burstLengths(1,i);
   calculatedBurstDeviation = burstLengths(5,i);
   calculatedVoicedLength = cryLengths(1,i);
   calculatedPauseLength = pauseLengths(1,i);
   
   
   if  calculatedBurstLength > originalBurstLength + eTime + originalBurstLength*originalBurstVariance/2 || calculatedBurstLength < originalBurstLength - eTime - originalBurstLength*originalBurstVariance/2
        allFine = 0;
        bustLengthProblem = 1;
   end
   
   calVoicedRatio1 = calculatedVoicedLength/calculatedBurstLength;
   if calVoicedRatio1 > originalVoicedRatio + ePerc || calVoicedRatio1 < originalVoicedRatio - ePerc
      allFine = 0; 
      voicedRatioProblem1 = 1;
   end
   
   calVoicedRatio2 = 1 - calculatedPauseLength/calculatedBurstLength;
   if calVoicedRatio2 > originalVoicedRatio + ePerc || calVoicedRatio2 < originalVoicedRatio - ePerc
      allFine = 0; 
       voicedRatioProblem2 = 1;
   end
   
   calBurstVariance = 2*calculatedBurstDeviation/calculatedBurstLength;
    if calBurstVariance > originalBurstVariance + originalBurstVariance*ePerc + ePerc || calBurstVariance < originalBurstVariance - originalBurstVariance*ePerc - ePerc
      allFine = 0; 
      burstVarianceProblem = 1;
    end
   
   if calculatedDuration > originalDuration + originalDuration*ePerc || calculatedDuration < originalDuration - originalDuration*ePerc
       allFine = 0;
      durationProblem = 1;
   else
   
   
end



if allFine == 0
   warning('assertion ended false. Either the Signal-Generation or the Analysis is wrong!'); 
else
   disp('!!! This segment was fine =) !!!');
end


end

