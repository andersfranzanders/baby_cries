function [  breakpoints,densitiesOfSegments,global_errors,global_meanRatios] = SWS_relativeErrorThreshold( Cs,threshold )

windowStart = 1;
numCs = length(Cs);

global_errors = zeros(1,numCs);
global_meanRatios = zeros(1,numCs);
breakpoints = zeros(1,numCs);
densitiesOfSegments = zeros(1,numCs);

densitiesOfWindow = [];
errorsOfWindow = [];

for windowEnd = 2:numCs
    breakpoints(windowEnd) = 0;
    
    window = Cs(windowStart:windowEnd);
    densOfThisWindow = trapz(window);
    densitiesOfWindow = [densitiesOfWindow, densOfThisWindow];
    
    [new_error] = linearRegression(densitiesOfWindow);
    errorsOfWindow = [errorsOfWindow,new_error];
    global_meanRatios(windowEnd) = length(errorsOfWindow) * 0.2;
   
   
    %if new_error > threshold
    if new_error > global_meanRatios(windowEnd)
        breakpoints(windowEnd) = 1;
        breakpoints(windowEnd-1) = -1;
        densitiesOfSegments(windowStart: windowEnd) = mean(densitiesOfWindow);

        windowStart =  windowEnd;
        densitiesOfWindow = [];
        errorsOfWindow =[];
       
    end
    
    global_errors(windowEnd) = new_error;
    
    
end
densitiesOfSegments(windowStart:windowEnd) = mean(densitiesOfWindow);

end



