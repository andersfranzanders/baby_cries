function [ CMatrix ] = convertClassSignalToMatrix( Cs,Fs )

CMatrix = [];
startPoint = 0;
for i=1:length(Cs)-1
    
    if Cs(i) == 0 && Cs(i+1) == 1
        startPoint = i/Fs;
    end

    if Cs(i) == 1 && Cs(i+1) == 0
        endPoint = i/Fs;
        CMatrix = [CMatrix; startPoint, endPoint];
    end

end



end

