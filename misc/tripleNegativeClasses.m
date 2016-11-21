function [ out_M ] = tripleNegativeClasses( M )

[rows,cols] = size(M);
negativeM = zeros(1,cols);
for i = 1:rows
    thisRow = M(i,:);
    if thisRow(end) == 0
       negativeM = cat(1,negativeM,thisRow); 
       negativeM = cat(1,negativeM,thisRow); 
    end
end

out_M = cat(1,M,negativeM);


end


