function [ sep_point, densities, regLines ] = top_down_densities( Cs )

densities = zeros(1,length(Cs));
regLines = zeros(1,length(Cs));

%seppoints = 5:25:length(Cs)-5;
startArea = floor(0.5*length(Cs));
endArea = length(Cs);
pointsToTest = floor((endArea - startArea)/10);

seppoints = startArea:pointsToTest:endArea;
errors = zeros(1,length(seppoints));

leftDensities = [];
rightDensities = [];
for i = 1:length(seppoints)
    sep_point = seppoints (i);
    
    left_Segment = Cs(1:sep_point);
    for j=1:length(left_Segment)
        leftDensities = [leftDensities, trapz(left_Segment(1:j))];
    end
    [left_error, left_regLine] = linearRegression(leftDensities);
    
    right_Segment = Cs(sep_point:end);
    for k=1:length(right_Segment)
        rightDensities = [rightDensities, trapz(right_Segment(1:k))];
    end
    [right_error, right_regLine] = linearRegression(rightDensities);
    errors(i) = left_error+right_error;
    
    densities(1:sep_point) = leftDensities;
    densities(sep_point:end) = rightDensities;
    
    leftDensities = [];
    rightDensities = [];
end

[minvalue,minindex] = min(errors);
sep_point = seppoints(minindex);

left_Segment = Cs(1:sep_point);
for j=1:length(left_Segment)
    leftDensities = [leftDensities, trapz(left_Segment(1:j))];
end
[left_error, left_regLine] = linearRegression(leftDensities);

right_Segment = Cs(sep_point:end);
for k=1:length(right_Segment)
    rightDensities = [rightDensities, trapz(right_Segment(1:k))];
end
[right_error, right_regLine] = linearRegression(rightDensities);

densities(1:sep_point) = leftDensities;
densities(sep_point:end) = rightDensities;
regLines(1:sep_point) = left_regLine;
regLines(sep_point:end) = right_regLine;

end

