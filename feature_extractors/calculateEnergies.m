function [ Es ] = calculateEnergies( xAsWindows )

[rows,cols] = size(xAsWindows);
Es = zeros(1,rows);

for i = 1:rows
    Es(i) = sqrt(mean(xAsWindows(i,:).^2));
end

