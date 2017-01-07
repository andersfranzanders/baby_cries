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

cryLengthData = zeros(5,1);
if ~isempty(cryLenghts)
    cryLengthData(1) = mean(cryLenghts);
    cryLengthData(2) = median(cryLenghts);
    cryLengthData(3) = max(cryLenghts);
    cryLengthData(4) = min(cryLenghts);
    cryLengthData(5) = std(cryLenghts);
end

end

