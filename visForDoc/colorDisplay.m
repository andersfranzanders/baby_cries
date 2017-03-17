

x = 0:0.001:1;


for i =1:length(x)
    rgb = RegionScoreToRGB(x(i));
    
    
    subplot(2,1,1);
    hold on;
    stem(x(i),1,'Color',rgb);
end

