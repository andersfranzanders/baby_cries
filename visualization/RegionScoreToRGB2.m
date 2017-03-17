function [ rgb ] = RegionScoreToRGB2( score )
b = 0;

r = score^0.3;
    
g = (-score+1)^0.3;


rgb = [r,g,b];

end

