function [ ampelMatrix ] = convertValuesToAmpelableM( values,segmentMatrix, support,minValue,maxValue,isOneGood,linearityFactor)

silenceValue = 0;
if isOneGood
   silenceValue = maxValue;
else
   silenceValue = minValue;
end

[rows,cols] = size(segmentMatrix);

lastEnd = 1;
filledSegmentMatrix = [];
filledValues = [];
for i = 1:rows
    thisStart = segmentMatrix(i,1);
    filledSegmentMatrix = [filledSegmentMatrix; lastEnd, thisStart];
    filledValues = [filledValues,silenceValue];
    
    filledSegmentMatrix = [filledSegmentMatrix; segmentMatrix(i,:)];
    filledValues = [filledValues,values(1,i)];
    
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
    ampelMatrix(i,3:5) = mapValueToAmpelColor(filledValues(1,i),minValue,maxValue,isOneGood,linearityFactor);
    
end

end

