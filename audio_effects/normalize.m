function [ x ] = normalize( x )
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


end

