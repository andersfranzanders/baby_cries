function [ segmentsForViz, ampelDensities,ampelTempos,ampelBursts,ampelDurations ] = easySegmentation_ampelplot( Cs, support, x, originalWindowLengthInMs, maxPause)

[ segmentMatrix ] = calSegmentsByMaxPause( Cs, originalWindowLengthInMs, maxPause);
[ densities,tpm,burstLengths, cryLengths, pauseLengths, energies,durations ] = calFeaturesOfSegments( Cs, support, x, segmentMatrix , originalWindowLengthInMs)

segmentsForViz = zeros(1,length(Cs));
tpmForViz  = zeros(1,length(Cs));
[rows,cols] = size(segmentMatrix);
for i = 1:rows
    sStart = segmentMatrix(i,1);
    sEnd = segmentMatrix(i,2);
    segmentsForViz(sStart:sEnd) = densities(i);
    tpmForViz(sStart:sEnd) = tpm(i);
end



ampelDensities = convertValuesToAmpelableM(densities,segmentMatrix,support,0,0.9,0,1);
ampelTempos = convertValuesToAmpelableM(tpm,segmentMatrix,support,0,100,0, 0.7);
ampelBursts = convertValuesToAmpelableM(burstLengths,segmentMatrix,support,0,4+maxPause,0,0.6);
ampelDurations = convertValuesToAmpelableM(durations,segmentMatrix,support,0,120,0,1);
end

