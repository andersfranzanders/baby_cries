function [ breakpointsDens, densities, breakpointsTempo, tempos, tempoErrors] = SWTD_cascaded( Cs, densitiesThreshold, tempoThreshold )

[breakpointsDens,densities] = SWTD_generic_RSEThreshold(Cs,'densities',densitiesThreshold);

breakpointIndexes = find(breakpointsDens);
breakpointIndexes = [1, breakpointIndexes, length(Cs) ];

breakpointsTempo = [0];
tempos = [0];
tempoErrors = [0];

for i=1:length(breakpointIndexes)-1;
   segmentStart = breakpointIndexes(i);
   segmentEnd = breakpointIndexes(i+1)-1;
   window = Cs(segmentStart:segmentEnd);
   
   [windowTempoBreakpoints, windowTempos, windowErrors] = SWTD_generic_RSEThreshold(window,'tempo',tempoThreshold);
   breakpointsTempo = [breakpointsTempo, windowTempoBreakpoints];
   tempos = [tempos, windowTempos];
   tempoErrors = [tempoErrors, windowErrors];
   
   
end



end

