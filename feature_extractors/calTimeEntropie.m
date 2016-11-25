function [ timeEntropie ] = calTimeEntropie( xInWindows )


[rows,cols] = size(xInWindows);
timeEntropie = zeros(1,rows);
for i = 1:rows
    window = xInWindows(i,:);
    %[N] = histcounts(window,100);
    window = normalize(window);
    timeEntropie(i) = sum(window.*log(window+2));
    %timeEntropie(i) = sum(N.*log(N+1));
end


end

