function [  breakpoints,densitiesOfSegments,global_errors,global_densities, global_derivatives,global_regLines ] = SWTD_densities_errorThreshold( Cs,threshold )


numCs = length(Cs);

global_errors = zeros(1,numCs);
global_densities = zeros(1,numCs);
global_derivatives = zeros(1,numCs);
breakpoints = zeros(1,numCs);
global_regLines = zeros(1,numCs);
densitiesOfSegments = zeros(1,numCs);

densitiesOfWindow = [0];
windowStart = 1;
windowEnd = 2;
while windowEnd < numCs
    breakpoints(windowEnd) = 0;
    
    window = Cs(windowStart:windowEnd);
    densOfThisWindow = trapz(window);
    global_densities(windowEnd) = densOfThisWindow;
    
    densitiesOfWindow = [densitiesOfWindow, densOfThisWindow];
    
    [new_error,currentRegLine] = linearRegression(densitiesOfWindow);
    if global_errors(windowEnd) == 0
        global_errors(windowEnd) = new_error;
    end
    
    if new_error > threshold
        [seppoint] = TopDown_densities(window);
        new_windowEnd = windowStart+seppoint-1;
        breakpoints(new_windowEnd ) = 1;
        breakpoints(new_windowEnd - 1 ) = -1;
        
        densitiesOfSegments(windowStart: windowEnd) = densitiesOfWindow(seppoint)/length(densitiesOfWindow(1:seppoint));
        global_regLines(windowStart: windowEnd) = currentRegLine;
        
        
        windowStart = new_windowEnd;
        windowEnd = windowStart + 1;
        densitiesOfWindow = [0];
        
    else
        windowEnd = windowEnd+1;
    end
    
    
    
end
global_regLines(windowStart:windowEnd-1) = currentRegLine;
densitiesOfSegments(windowStart:windowEnd) = densitiesOfWindow(end)/length(densitiesOfWindow);