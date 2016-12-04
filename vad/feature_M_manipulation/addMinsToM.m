function [ MwithMins ] = addMinsToM( M, minWindow, originalWindowLengthInMs )


[rows,cols] = size(M);
MwithMins = zeros(rows,cols*2-1);
M = abs(M);

numOfWindows = (2*minWindow/(0.001*originalWindowLengthInMs) ) - 1;

for i = 1:rows
    backPos = i - numOfWindows;
    if (backPos<1)
        backPos = 1;
    end
    
    if i ~=1
        minVektor = min(M(backPos:i,:));
    else 
        minVektor = M(i,:);
    end
    minVektor = M(i,:) - minVektor;
    
    MwithMins(i,1:cols-1) = M(i,1:cols-1);
    MwithMins(i,end) = M(i,cols);
    MwithMins(i,cols:end-1) = minVektor(1:end-1);

end


end

