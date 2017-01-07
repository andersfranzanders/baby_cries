function [ densities,tpm ] = calFeaturesOfSegments( Cs, segmentMatrix,windowLengthInMs )

[rows,cols] = size(segmentMatrix);

densities = zeros(1,rows);
tpm = zeros(1,rows);
cryLengths = zeros(5,rows);
pauseLengths = zeros(5,rows);
burstLengths = zeros(5,rows);


for i = 1:rows
    segStart = segmentMatrix(i,1);
    segEnd = segmentMatrix(i,2);
    segment = Cs(segStart:segEnd);
    
    densities(i) = calDensitie(segment);
    tpm(i) = calTPM(segment,windowLengthInMs);
    cryLengths(:,i) = calCryLenghts(segment, windowLengthInMs,1,-1);
    pauseLengths(:,i) = calCryLenghts(segment, windowLengthInMs,-1,1);
    burstLengths(:,i) = calBurstLengths(segment,windowLengthInMs);
end
cryLengths
pauseLengths
burstLengths

end

