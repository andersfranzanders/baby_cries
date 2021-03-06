function [ error,y_hut ] = linearRegression( y )

if length(y) > 1

    %cal regression line
    x = 1:length(y);

    meanX = mean(x);
    meanY = mean(y);
    b1 = sum( (x-meanX).*(y-meanY) ) / sum( (x-meanX).^2 );
    b0 = meanY - b1*meanX;

    y_hut = b1*x+b0;

    error = sum( (y-y_hut ).^2 ) / (length(y)-1);

else
    error = 0;
    y_hut = 0;
end


end

