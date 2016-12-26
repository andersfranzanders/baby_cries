function [ densities, y_hut_combined, errors, breakpoints ] = timeSegmentation_old( Cs,threshold )


rows = length(Cs);
errors = [];
densities = zeros(1,rows);
breakpoints = zeros(1,rows);
y_hut_combined = zeros(1,rows);
segmentStart = 1;
for i = 1:rows
    densities(i) = trapz(Cs(segmentStart:i));
    [ error,y_hut ] = linearRegression( densities(segmentStart:i) );
    errors = [errors, error];
    div_errors = diff(errors).^2;
    
    breakpoints(i) = 0;
    if i > 1
        if div_errors(i-1) > threshold
            y_hut_combined(segmentStart:i) = y_hut;
            segmentStart = i;
            breakpoints(i) = 1;
        end
    end
end

y_hut_combined(segmentStart:end) = y_hut;

%errors = diff(errors).^2;
%errors = [errors,0];

%cal regression line
 [ error,y_hut ] = linearRegression( densities );


end