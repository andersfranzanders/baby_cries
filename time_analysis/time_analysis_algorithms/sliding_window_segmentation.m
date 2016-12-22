function [ breakpoints,densitiesOfSegments,global_errors,global_densities, global_derivatives,global_regLines ] = sliding_window_segmentation( Cs, threshold )

windowStart = 1;
numCs = length(Cs);

global_errors = zeros(1,numCs);
global_densities = zeros(1,numCs);
global_derivatives = zeros(1,numCs);
breakpoints = zeros(1,numCs);
global_regLines = zeros(1,numCs);
densitiesOfSegments = zeros(1,numCs);

old_error = 0;
densitiesOfWindow = [];
for windowEnd = 2:numCs
    breakpoints(windowEnd) = 0;
    
    window = Cs(windowStart:windowEnd);
    densOfThisWindow = trapz(window);
    densitiesOfWindow = [densitiesOfWindow, densOfThisWindow];
    
    [new_error,currentRegLine] = linearRegression(densitiesOfWindow);
    error_difference = (new_error-old_error)^2;
    old_error = new_error;
    
    if error_difference > threshold
        breakpoints(windowEnd) = 1;
        densitiesOfSegments(windowStart:windowEnd) = mean(densitiesOfWindow);
        
        global_regLines(windowStart:windowEnd-1) = currentRegLine;
        windowStart = windowEnd;
        old_error = 0;
        densitiesOfWindow = [];
        
    end
    
    global_errors(windowEnd) = new_error;
    global_densities(windowEnd) = densOfThisWindow;
    global_derivatives(windowEnd) = error_difference;
    
end
global_regLines(windowStart:windowEnd-1) = currentRegLine;
densitiesOfSegments(windowStart:windowEnd) = mean(densitiesOfWindow);

end

