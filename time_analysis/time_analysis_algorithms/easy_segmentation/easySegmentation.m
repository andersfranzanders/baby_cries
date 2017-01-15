function [ segmentsForViz,burstLengths, cryLengths, pauseLengths, energies,durations ] = easySegmentation( Cs, support, x, originalWindowLengthInMs, maxPause)

[ segmentMatrix ] = calSegmentsByMaxPause( Cs, originalWindowLengthInMs, maxPause);

[ densities,tpm, burstLengths, cryLengths, pauseLengths, energies,durations ] = calFeaturesOfSegments( Cs, support, x, segmentMatrix , originalWindowLengthInMs);

segmentsForViz = zeros(1,length(Cs));

tpmForViz  = zeros(1,length(Cs));
[rows,cols] = size(segmentMatrix);

for i = 1:rows
    sStart = segmentMatrix(i,1);
    sEnd = segmentMatrix(i,2);
    segmentsForViz(sStart:sEnd) = densities(i);
    tpmForViz(sStart:sEnd) = tpm(i);
end

end

