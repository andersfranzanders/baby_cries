function [ segments,segmentMarkerSignal ] = pipeline_segment( cryUnits, ts, Fs,support )

segments = [];
thisSeg = cryUnits(1,:);
[rows,cols] = size(cryUnits);
for j = 2:rows
    cu_i_end = cryUnits(j-1,2);
    cu_j_start = cryUnits(j,1);
    d = (cu_j_start - cu_i_end)/Fs;
    
    if d < ts
       thisSeg = [thisSeg; cryUnits(j,:)];
    else
       segments = [segments, {thisSeg}];
       thisSeg = cryUnits(j,:);
    end
end

segments = [segments, {thisSeg}];

segmentMarkerSignal = zeros(length(support));

for i = 1:length(segments)
   thisSegment = segments{i};
   segStart = find(support == thisSegment(1,1));
   segEnd = find(support == thisSegment(end,2));
   segmentMarkerSignal(segStart:segEnd) = 1;
end

end

