function [ x ] = compressDynamicly(x,aimRms)


x = normalize(x);

%compute threshold and ratio
rms = sqrt(mean(x.^2));

threshold = (rms/aimRms)^2.3;
ratio = (rms/aimRms)^2.3;

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

x = normalize(x);

end


