function [ densitie ] = calDensitie( segment )


densitie = trapz(segment)/length(segment);


end