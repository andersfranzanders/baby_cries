function [ segmentsForViz,densAmpelViz ] = easySegmentation( Cs, support, x, originalWindowLengthInMs, maxPause)

[ segmentMatrix ] = calSegmentsByMaxPause( Cs, originalWindowLengthInMs, maxPause);

[ densities,tpm, burstLengths, cryLengths, pauseLengths, energies ] = calFeaturesOfSegments( Cs, support, x, segmentMatrix , originalWindowLengthInMs);

segmentsForViz = zeros(1,length(Cs));
densAmpelViz = zeros(1,Length(Cs));

tpmForViz  = zeros(1,length(Cs));
[rows,cols] = size(segmentMatrix);

for i = 1:rows
    sStart = segmentMatrix(i,1);
    sEnd = segmentMatrix(i,2);
    segmentsForViz(sStart:sEnd) = densities(i);
    tpmForViz(sStart:sEnd) = tpm(i);
end

end

