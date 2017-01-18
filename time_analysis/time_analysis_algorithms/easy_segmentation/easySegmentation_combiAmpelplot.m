function [ combiAmpelData ] = easySegmentation_combiAmpelplot( Cs, support, x, originalWindowLengthInMs, maxPause)

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



combiAmpelData = convertValuesToCombiAmpel(durations,0,120,densities,0,1,energies(1,:),0,0.3,segmentMatrix,support);
end

