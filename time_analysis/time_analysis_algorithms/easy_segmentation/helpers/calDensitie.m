function [ densitie ] = calDensitie( segment )


densitie = trapz(segment)/length(segment);

if densitie < 1
   v = 0; 
end

end

