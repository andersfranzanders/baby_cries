function [  breakpoints,featuresOfSegments,global_errors,global_features, global_derivatives,global_regLines ] = SWTD_generic_errorThreshold( Cs,feature,threshold )

if ~(strcmp(feature,'densities') == 1 || strcmp(feature,'tempo') == 1 )
    error('Enter feature: densities -or- tempo');
end

maxPossibleError = 0;
if (strcmp(feature,'densities') == 1 )
   maxPossibleError = 70;
end

if (strcmp(feature,'tempo') == 1 )
   maxPossibleError = 10;
end


diffCs = diff(Cs);
diffCs = [diffCs, 0 ];

numCs = length(Cs);
global_errors = zeros(1,numCs);
global_features = zeros(1,numCs);
global_derivatives = zeros(1,numCs);
breakpoints = zeros(1,numCs);
global_regLines = zeros(1,numCs);
featuresOfSegments = zeros(1,numCs);

featuresOfWindow = [0];
windowStart = 1;
windowEnd = 2;
currentFeature = 0;
while windowEnd < numCs
    breakpoints(windowEnd) = 0;
    
    window = Cs(windowStart:windowEnd);
    diffWindow = diffCs(windowStart:windowEnd);
    
    if strcmp(feature,'densities') == 1
        currentFeature = trapz(window);
    end
     if strcmp(feature,'tempo') == 1
        currentFeature = sum(diffWindow ~= 0);
    end
    
    global_features(windowEnd) = currentFeature;
    
    featuresOfWindow = [featuresOfWindow, currentFeature];
    
    [new_error,currentRegLine] = linearRegression(featuresOfWindow);
    new_error = sqrt(new_error)/maxPossibleError;
    if global_errors(windowEnd) == 0
        global_errors(windowEnd) = new_error;
    end
    
    if new_error > threshold
        [seppoint] = TopDown_generic(window,feature);
        new_windowEnd = windowStart+seppoint-1;
        breakpoints(new_windowEnd ) = 1;
        breakpoints(new_windowEnd - 1 ) = -1;
        
        featuresOfSegments(windowStart: windowEnd) = featuresOfWindow(seppoint)/length(featuresOfWindow(1:seppoint));
        global_regLines(windowStart: windowEnd) = currentRegLine;
        
        
        windowStart = new_windowEnd;
        windowEnd = windowStart + 1;
        featuresOfWindow = [0];
        
    else
        windowEnd = windowEnd+1;
    end
    
    
    
end
global_regLines(windowStart:windowEnd-1) = currentRegLine;
featuresOfSegments(windowStart:windowEnd) = featuresOfWindow(end)/length(featuresOfWindow);

 if strcmp(feature,'tempo') == 1
     featuresOfSegments = featuresOfSegments * -10;
    
 end