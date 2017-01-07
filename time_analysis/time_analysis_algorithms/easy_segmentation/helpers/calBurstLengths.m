function [ burstData ] = calBurstLengths( segment, windowLengthInMs )


segment = [0,segment];

burstLengths = [];
seg_diff = diff(segment);

oldStart = 1;
for i =2:length(seg_diff);
    if seg_diff(i) == 1
       burstLengths = [burstLengths, i - oldStart];
       oldStart = i;
    end
    if i == length(seg_diff)
       burstLengths = [burstLengths, i - oldStart];
    end
end

burstLengths = burstLengths * windowLengthInMs/(2*1000);

burstData = zeros(5,1);
burstData(1) = mean(burstLengths);
burstData(2) = median(burstLengths);
burstData(3) = max(burstLengths);
burstData(4) = min(burstLengths);
burstData(5) = std(burstLengths);


end

