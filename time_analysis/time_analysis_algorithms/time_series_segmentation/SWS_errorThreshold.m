function [  breakpoints,densitiesOfSegments,global_errors,global_densities, global_derivatives,global_regLines ] = SWS_errorThreshold( Cs,threshold )

windowStart = 1;
numCs = length(Cs);

global_errors = zeros(1,numCs);
global_densities = zeros(1,numCs);
global_derivatives = zeros(1,numCs);
breakpoints = zeros(1,numCs);
global_regLines = zeros(1,numCs);
densitiesOfSegments = zeros(1,numCs);

densitiesOfWindow = [];

for windowEnd = 2:numCs
    breakpoints(windowEnd) = 0;
    
    window = Cs(windowStart:windowEnd);
    densOfThisWindow = trapz(window);
    densitiesOfWindow = [densitiesOfWindow, densOfThisWindow];
    
    [new_error,currentRegLine] = linearRegression(densitiesOfWindow);
    
    if new_error > threshold
        
        breakpoints(windowEnd) = 1;
        breakpoints(windowEnd-1) = -1;
        densitiesOfSegments(windowStart: windowEnd) = mean(densitiesOfWindow);
        global_regLines(windowStart: windowEnd-1) = currentRegLine;
        
        
        windowStart =  windowEnd;
        densitiesOfWindow = [];
        
    end
    
    global_errors(windowEnd) = new_error;
    global_densities(windowEnd) = densOfThisWindow;
    
end
global_regLines(windowStart:windowEnd-1) = currentRegLine;
densitiesOfSegments(windowStart:windowEnd) = mean(densitiesOfWindow);


end

