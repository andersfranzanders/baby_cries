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
newBurstLengths = burstLengths(1:end-1);

burstData = zeros(5,1);
if ~isempty(newBurstLengths)
    burstData(1) = mean(newBurstLengths);
    burstData(2) = median(newBurstLengths);
    burstData(3) = max(newBurstLengths);
    burstData(4) = min(newBurstLengths);
    burstData(5) = std(newBurstLengths);
end


end

