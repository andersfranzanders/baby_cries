function [ x ] = compress( x, threshold, ratio )

% normalize
gain = 0;
if max(x) > -min(x)
    gain = 1/max(x);
else 
    gain = -1/min(x);
end

    
for i = 1:length(x)
    x(i) = x(i) * gain;
end

%compress
for i = 1:length(x)
    if x(i) > threshold || x(i) < -threshold
        if x(i) > 0
            difference = x(i) - threshold;
            x(i) = threshold + difference * ratio;
        else 
            difference = x(i) + threshold;
            x(i) = -threshold + difference * ratio;
        end
        
    end      
end

%normalize again
gain = 0;
if max(x) > -min(x)
    gain = 1/max(x);
else 
    gain = -1/min(x);
end

for i = 1:length(x)
    x(i) = x(i) * gain;
end

end

