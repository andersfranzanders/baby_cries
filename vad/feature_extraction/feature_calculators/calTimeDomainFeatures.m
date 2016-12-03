function [ RMSfeats, ZCRfeats ] = calTimeDomainFeatures( xInWindows )

[rows,cols] = size(xInWindows);
RMSfeats = zeros(1,rows);
ZCRfeats = zeros(1,rows);

for i = 1:rows
    
    window = xInWindows(i,:);
    
    RMSfeats(i) = sqrt(mean(window.^2));
    
    crossings = 0;
    for j = 1:length(window)-1
        if (window(j) > 0 && window(j+1) < 0 ) || (window(j) < 0 && window(j+1) > 0 )
            crossings = crossings+1;
        end
    end
    crossings = crossings/length(window);
    ZCRfeats(i) = crossings;
end

end

