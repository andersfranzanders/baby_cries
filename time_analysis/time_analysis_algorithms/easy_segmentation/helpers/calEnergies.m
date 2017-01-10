function energyData = calEnergies(segment, support, x)

new_support = support-min(support)+1;
segment = [0,segment];


energies = [];
seg_diff = diff(segment);

startMark = 1;
endMark = -1;

segStart = 1;
for i =1:length(seg_diff);
    if seg_diff(i) == startMark
        segStart = i;
    end
    if seg_diff(i) == endMark && i > 1
       cry = x(new_support(segStart):new_support(i));
       energyOfCry = sqrt(mean(cry.^2));
       energies = [energies, energyOfCry];
    end
end

energyData = zeros(5,1);
if ~isempty(energies)
    energyData(1) = mean(energies);
    energyData(2) = median(energies);
    energyData(3) = max(energies);
    energyData(4) = min(energies);
    energyData(5) = std(energies);
end

end

