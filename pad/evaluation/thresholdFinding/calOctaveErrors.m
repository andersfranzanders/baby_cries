function [ errors ] = calOctaveErrors( M )

[rows,cols] = size(M);
errors = zeros(1,rows);

for i =1:rows
    pitchSignal = M(i,:);
    error = 0;
    
    for j = 1:cols-1    
        if pitchSignal(j) > 0 && pitchSignal(j+1) > 0
            if pitchSignal(j+1) <= 0.6 * pitchSignal(j) || pitchSignal(j+1) >= 1.9 * pitchSignal(j)
                error = error+1;
            end
        end    
    end
    errors(i) = error;
    
end



end

