function [ segments] = calSegmentsByMaxPause( Cs, originalWindowLengthInMs, maxPause)


numFrames = length(Cs);
maxPauseFrames = (2*maxPause/(0.001*originalWindowLengthInMs) ) - 1;


diffCs = diff(Cs);
diffCs = [0,diffCs ];


segments = [];

segmentStart = 0;
segmentEnd = 0;
consPauseFrames = 0;
for i =1:numFrames
    if diffCs(i) == 1
        consPauseFrames = 0;
        if segmentStart == 0
            segmentStart = i;
        end
    end
    if diffCs(i) == -1
        segmentEnd = i;
        consPauseFrames = 1;
    end
    
    if consPauseFrames >= 1 && segmentStart ~= 0
        consPauseFrames = consPauseFrames + 1;
        if consPauseFrames >= maxPauseFrames
            segments = [segments; segmentStart, segmentEnd];
            segmentStart = 0;
        end
    end
    
    if i == numFrames && segmentStart ~= 0
           segments = [segments; segmentStart, segmentEnd]; 
    end
end


end

