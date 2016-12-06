function [ x] = centerClipping( x )

maxValue = max(x);
C = maxValue/2;

for i = 1:length(x)
    
    if abs(x(i)) < C
        x(i) = 0;
    end
    
    if x(i) >= C
        x(i) = x(i) - C;
    end
    
    if x(i) <= -C
        x(i) = x(i) + C;
    end
    
    
end

end

