function [ outM ] = postProcessM02( M )

outM = zeros(1,length(M));
segments = zeros(1,2);

for i = 2:length(M)
    startPoint = 0;
   	if M(i) == 0.8 && M(i-1) == 0;
       startPoint =  i; 
    end
    
    if M(i) == 0 && M(i-1) == 0.8;
       segment = [startPoint, i];
       segments = cat(1,segments,segment);
    end
end

segments


end

