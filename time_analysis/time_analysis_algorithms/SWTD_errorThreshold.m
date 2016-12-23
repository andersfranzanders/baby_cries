function [  breakpoints,densitiesOfSegments,global_errors,global_densities, global_derivatives,global_regLines ] = SWTD_errorThreshold( Cs,threshold )

windowStart = 1;
numCs = length(Cs);

global_errors = zeros(1,numCs);
global_densities = zeros(1,numCs);
global_derivatives = zeros(1,numCs);
breakpoints = zeros(1,numCs);
global_regLines = zeros(1,numCs);
densitiesOfSegments = zeros(1,numCs);

densitiesOfWindow = [];
windowEnd = 2;
while windowEnd < numCs
    breakpoints(windowEnd) = 0;
    
    window = Cs(windowStart:windowEnd);
    densOfThisWindow = trapz(window);
    densitiesOfWindow = [densitiesOfWindow, densOfThisWindow];
    
    [new_error,currentRegLine] = linearRegression(densitiesOfWindow);
    
    if new_error > threshold
        [seppoint] = top_down_densities(window);
        new_windowEnd = windowStart+seppoint;
        breakpoints(new_windowEnd ) = 1.5;
        breakpoints(new_windowEnd - 1 ) = -1.5;
        
        theMean = mean(densitiesOfWindow);
        densitiesOfSegments(windowStart: windowEnd) = theMean;
        global_regLines(windowStart: windowEnd-1) = currentRegLine;
        
        
        windowStart = new_windowEnd;
        windowEnd = windowStart + 1;
        densitiesOfWindow = [];
        
    else
        windowEnd = windowEnd+1;
    end
    
    global_errors(windowEnd) = new_error;
    global_densities(windowEnd) = densOfThisWindow;
    
end
%global_regLines(windowStart:windowEnd) = currentRegLine;
densitiesOfSegments(windowStart:windowEnd) = mean(densitiesOfWindow);