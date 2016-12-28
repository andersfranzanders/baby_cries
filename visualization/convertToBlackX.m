function [ new_x ] = convertToBlackX( x,Cs,Csupport )

new_x = zeros(1,length(x));

diffedCs = diff(Cs);
startEndPoints = [];
startPoint = 1;

for i = 1:length(diffedCs)
    if diffedCs(i) == 1
        startPoint = Csupport(i);
    end
    if diffedCs(i) == -1
        endPoint = Csupport(i);
        startEndPoints = [startEndPoints; startPoint endPoint];
    end
end

[rows,cols] = size(startEndPoints);

for i = 1:rows
    startPoint = startEndPoints(i,1);
    endPoint = startEndPoints(i,2);
    new_x(startPoint:endPoint) = x(startPoint:endPoint);

end

end

