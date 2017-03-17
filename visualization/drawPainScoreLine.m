function [ nothing ] = drawPainScoreLine( viz_data,subplot_info,LineWidth,Fs )

[rows,cols] = size(viz_data);

for i =1:cols
    
    startpoint = viz_data(1,i);
    endpoint = viz_data(2,i);
    rgb_color = viz_data(3:5,i);
    dummy_support = startpoint*Fs:(endpoint*Fs)-1;
    dummy_data = zeros(1,length(dummy_support));
   
    
    hold on;
    subplot(subplot_info(1),subplot_info(2),subplot_info(3));
    plot(dummy_support./Fs,dummy_data,'Color',rgb_color,'LineWidth',LineWidth);
    axis([0 max(viz_data(2,:)) -1 1]);
end

end

