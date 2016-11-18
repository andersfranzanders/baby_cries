function [ x ] = limitDynamicly( x,aimRms )

x = normalize(x);
rms = sqrt(mean(x.^2))
threshold = (rms/aimRms)^2;

%compress
for i = 1:length(x)
    if x(i) > threshold 
       x(i) = threshold;
    end 
    if x(i) < -threshold 
       x(i) = -threshold;
    end 
end

x = normalize(x);
rms = sqrt(mean(x.^2))

end

