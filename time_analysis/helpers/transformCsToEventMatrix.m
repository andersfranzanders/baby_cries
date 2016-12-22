function [ M,lengthArray ] = transformCsToEventMatrix( Cs )

rows = length(Cs);
lengthArray = zeros(1,rows);

M = []
cry_startpoint = 0;

for i = 2:rows
    lengthArray(i) = 0;
    
    if Cs(i-1) == 0 && Cs(i) == 1
       cry_startpoint = i; 
    end
    
    if Cs(i-1) == 1 && Cs(i) == 0
       	crylength = i-cry_startpoint;
        M = [M;cry_startpoint, crylength, 1];
        lengthArray(cry_startpoint) = crylength;
    end
end



end

