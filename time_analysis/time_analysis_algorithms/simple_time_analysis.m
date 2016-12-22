function [ density, cpm,densVelo ] = simple_time_analysis(Cs, windowSizeInMs, lookBackTime )


numOfWindows = (2*lookBackTime/(0.001*windowSizeInMs) ) - 1;

rows = length(Cs);
density = zeros(1,rows);
cpm = zeros(1,rows);
densVelo = zeros(1,rows);
derivative = diff(Cs);
derivative = [derivative, 0 ];

for i = 1:rows
    backpos = i - numOfWindows;
    if backpos < 1
       backpos = 1;
    end
    
    density(i) = trapz(Cs(backpos:i))/(i-backpos);
    cpm(i) = sum(derivative(backpos:i) == 1) /10;
    densVelo(i) = density(i) * cpm(i);
   
end



end

