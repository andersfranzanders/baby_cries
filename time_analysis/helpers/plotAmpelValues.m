function [ ] = plotAmpelValues( subplot1,subplot2, suplot3,lineWidth,Fs,ampelMatrix )

[rows,cols] = size(ampelMatrix);
for j = 1:rows
    hold on;
    subplot(subplot1,subplot2, suplot3); 
    oni = zeros(1,ampelMatrix(j,2)-ampelMatrix(j,1)+1);
    suppi = ampelMatrix(j,1):ampelMatrix(j,2);
    plot(suppi/Fs,oni,'Color',ampelMatrix(j,3:5),'LineWidth',lineWidth);
end


end

