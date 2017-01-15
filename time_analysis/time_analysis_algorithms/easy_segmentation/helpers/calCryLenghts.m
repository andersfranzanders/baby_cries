function cryLengthData = calCryLenghts(segment, windowLengthInMs,startMark,endMark)

segment = [0,segment];

cryLenghts = [];
seg_diff = diff(segment);

segStart = 1;
for i =1:length(seg_diff);
    if seg_diff(i) == startMark
        segStart = i;
    end
    if seg_diff(i) == endMark && i > 1
       cryLenghts = [cryLenghts, i - segStart];
    end
end

cryLenghts = cryLenghts * windowLengthInMs/(2*1000);
newCryLengths = cryLenghts(1:end);

cryLengthData = zeros(5,1);
if ~isempty(newCryLengths)
    cryLengthData(1) = mean(newCryLengths);
    cryLengthData(2) = median(newCryLengths);
    cryLengthData(3) = max(newCryLengths);
    cryLengthData(4) = min(newCryLengths);
    cryLengthData(5) = std(newCryLengths);
end

end

