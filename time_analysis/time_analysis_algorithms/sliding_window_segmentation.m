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
errorDerivsOfWindow = [];
for windowEnd = 2:numCs
    breakpoints(windowEnd) = 0;
    
    window = Cs(windowStart:windowEnd);
    densOfThisWindow = trapz(window);
    densitiesOfWindow = [densitiesOfWindow, densOfThisWindow];
    
    [new_error,currentRegLine] = linearRegression(densitiesOfWindow);
    error_difference = (new_error-old_error)^2;
    errorDerivsOfWindow = [errorDerivsOfWindow, error_difference];
    old_error = new_error;
    
    if error_difference > threshold
    %if new_error > threshold
        
       
        theMean = mean(errorDerivsOfWindow(3:end));
        lastGoodPosition = find((errorDerivsOfWindow < theMean),1,'last');
        corrected_windowEnd = windowStart+lastGoodPosition;
        
        breakpoints(corrected_windowEnd) = 1;
        breakpoints(corrected_windowEnd-1) = -1;
        densitiesOfSegments(windowStart:corrected_windowEnd) = mean(densitiesOfWindow(1:lastGoodPosition));
        
        global_regLines(windowStart:corrected_windowEnd-1) = currentRegLine(1:lastGoodPosition);
        
        
        windowStart = corrected_windowEnd;
        old_error = 0;
        densitiesOfWindow = [];
        errorDerivsOfWindow = [];
        
    end
    
    global_errors(windowEnd) = new_error;
    global_densities(windowEnd) = densOfThisWindow;
    global_derivatives(windowEnd) = error_difference;
    
end
%global_regLines(windowStart:windowEnd-1) = currentRegLine;
densitiesOfSegments(windowStart:windowEnd) = mean(densitiesOfWindow);

end
