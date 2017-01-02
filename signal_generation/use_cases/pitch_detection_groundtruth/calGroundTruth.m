function [ gt_out ] = calGroundTruth( pitchMatrix,bestOnes)

errors = calOctaveErrors(pitchMatrix);

[sortedErrors,indizi] = sort(errors);
indiziToConsider = zeros(1,bestOnes);
for i = 1:bestOnes
   indiziToConsider(i) = indizi(i);
end



[rows,cols] = size(pitchMatrix);
gt = zeros(1,cols);

for i = 1:length(gt)
    %pitches = zeros(1,rows);
    pitches = zeros(1,bestOnes);
    
    %pitches(:) = pitchMatrix(:,i);
    pitches(:) = pitchMatrix(indiziToConsider,i);
    
    gt(i) = median(pitches);
    
end

gt_out =  medfilt1(gt,5);


end

