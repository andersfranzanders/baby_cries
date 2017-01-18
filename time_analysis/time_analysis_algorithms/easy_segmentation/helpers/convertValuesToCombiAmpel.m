function [ ampelMatrix ] = convertValuesToCombiAmpel( hueValues,hueMin,hueMax,satValues,satMin,satMax,heightValues,heightMin,heightMax,segmentMatrix,support)

silenceValue = [hueMin; satMax; heightMin];

[rows,cols] = size(segmentMatrix);

lastEnd = 1;
filledSegmentMatrix = [];
filledValues = [];
for i = 1:rows
    thisStart = segmentMatrix(i,1);
    filledSegmentMatrix = [filledSegmentMatrix; lastEnd, thisStart];
    filledValues = [filledValues,silenceValue];
    
    filledSegmentMatrix = [filledSegmentMatrix; segmentMatrix(i,:)];
    filledValues = [filledValues,[hueValues(1,i);satValues(1,i);heightValues(1,i)]];
    
    lastEnd = segmentMatrix(i,2);
end

if lastEnd ~= length(support)
    filledSegmentMatrix = [filledSegmentMatrix; lastEnd, length(support)];
    filledValues = [filledValues,silenceValue];
end





[rows,cols] = size(filledSegmentMatrix);

ampelMatrix = zeros(rows,5);
for i = 1:rows
    ampelMatrix(i,1) = support(filledSegmentMatrix(i,1));
    ampelMatrix(i,2) = support(filledSegmentMatrix(i,2));
    ampelMatrix(i,3) = filledValues(3,i)/heightMax;
    ampelMatrix(i,4:6) = mapValueToCombiAmpelColor(filledValues(:,i),hueMin,hueMax,satMin,satMax,0);
    
end

end

