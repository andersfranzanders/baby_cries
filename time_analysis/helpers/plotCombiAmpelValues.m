function [ ] = plotCombiAmpelValues( subplot1,subplot2, suplot3,maxLineWidth,Fs,ampelMatrix )

[rows,cols] = size(ampelMatrix);
for j = 1:rows
    hold on;
    subplot(subplot1,subplot2, suplot3); 
    oni = zeros(1,ampelMatrix(j,2)-ampelMatrix(j,1)+1);
    suppi = ampelMatrix(j,1):ampelMatrix(j,2);
    lineWidth = maxLineWidth*ampelMatrix(j,3)+10;
    plot(suppi/Fs,oni,'Color',ampelMatrix(j,4:6),'LineWidth',lineWidth);
end


end

