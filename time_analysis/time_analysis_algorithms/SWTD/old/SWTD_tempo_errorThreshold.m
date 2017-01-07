function [ breakpoints, global_tempos, global_errors,global_regLines ] = SWTD_tempo_errorThreshold( Cs, threshold )

numCs = length(Cs);
diffCs = diff(Cs);
diffCs = [diffCs, 0 ];

global_errors = zeros(1,numCs);
global_tempos = zeros(1,numCs);
global_regLines = zeros(1,numCs);
breakpoints = zeros(1,numCs);

temposOfThisWindow = [0];
windowStart = 1;
windowEnd = 2;
while windowEnd < numCs
    
    breakpoints(windowEnd) = 0;
    
    window = diffCs(windowStart:windowEnd);
    tempo = sum(window == 1);
    temposOfThisWindow = [temposOfThisWindow, tempo];
    global_tempos(windowEnd) = tempo;
    
    [new_error,currentRegLine] = linearRegression(temposOfThisWindow);
  	if global_errors(windowEnd) == 0
        global_errors(windowEnd) = new_error;
    end
    
    if new_error > threshold
        %[seppoint] = TopDown_densities(window);
        seppoint = windowEnd;
        new_windowEnd = windowStart+seppoint-1;
        breakpoints(new_windowEnd ) = 1;
        breakpoints(new_windowEnd - 1 ) = -1;
        
        %densitiesOfSegments(windowStart: windowEnd) = densitiesOfWindow(seppoint)/length(densitiesOfWindow(1:seppoint));
        global_regLines(windowStart: windowEnd) = currentRegLine;
        
        
        windowStart = new_windowEnd;
        windowEnd = windowStart + 1;
        temposOfThisWindow = [0];
        
    else
        windowEnd = windowEnd+1;
    end
    
end
%global_regLines(windowStart:windowEnd-1) = currentRegLine;
end

