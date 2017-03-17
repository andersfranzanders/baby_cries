function [ rgb ] = RegionScoreToRGB( score )

fg = 0.5;
fr = 0.2;

b = 0;

r = 1;



if score < 0.5
    r = 1/(0.5^fr)  * score^fr;
end
    

if score > 0.5
    g = 1/(0.5^fg) * (-score+1)^fg;
else
    g = 1;
end

rgb = [r,g,b];

end

