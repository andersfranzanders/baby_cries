function [ densities,tpm,burstLengths, cryLengths, pauseLengths, energies,durations ] = calFeaturesOfSegments( Cs, support, x, segmentMatrix,windowLengthInMs )

[rows,cols] = size(segmentMatrix);

densities = zeros(1,rows);
tpm = zeros(1,rows);
durations = zeros(1,rows);
cryLengths = zeros(5,rows);
pauseLengths = zeros(5,rows);
burstLengths = zeros(5,rows);
energies = zeros(5,rows);


for i = 1:rows
    segStart = segmentMatrix(i,1);
    segEnd = segmentMatrix(i,2);
    Cs_segment = Cs(segStart:segEnd);
    x_segment = x(support(segStart):support(segEnd));
    support_segment = support(segStart:segEnd);
    
    durations(i) = (segEnd - segStart)*windowLengthInMs*0.001/2;
    densities(i) = calDensitie(Cs_segment);
    tpm(i) = calTPM(Cs_segment,windowLengthInMs);
    cryLengths(:,i) = calCryLenghts(Cs_segment, windowLengthInMs,1,-1);
    pauseLengths(:,i) = calCryLenghts(Cs_segment, windowLengthInMs,-1,1);
    burstLengths(:,i) = calBurstLengths(Cs_segment,windowLengthInMs);
    energies(:,i) = calEnergies(Cs_segment, support_segment, x_segment);
end

durations;
cryLengths;
pauseLengths;
burstLengths;
energies;


end

