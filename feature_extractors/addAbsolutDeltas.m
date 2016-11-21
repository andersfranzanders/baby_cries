function [ MwithDeltas ] = addAbsolutDeltas(M)

[rows,cols] = size(M);
MwithDeltas = zeros(rows,cols*2-1);

for i =1:rows
    windowAfter = i+1;
    windowBefore = i-1;
    if windowAfter > rows
        windowAfter = rows;
    end
    if windowBefore < 1
        windowBefore = 1;
    end
        
    
    deltaVektor = ( M(windowAfter,:) - M(windowBefore,:) ) / 2;
    deltaVektor = abs(deltaVektor);
    MwithDeltas(i,1:cols-1) = M(i,1:cols-1);
    MwithDeltas(i,end) = M(i,cols);
    MwithDeltas(i,cols:end-1) = deltaVektor(1:end-1);

end



end

