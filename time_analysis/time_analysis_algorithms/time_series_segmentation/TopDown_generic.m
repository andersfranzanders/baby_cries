function [ sep_point, features, regLines ] = TopDown_generic( Cs,feature )

if ~(strcmp(feature,'densities') == 1 || strcmp(feature,'tempo') == 1 )
    error('Enter Feauture: densities -or- tempo');
end


diffCs = diff(Cs);
diffCs = [diffCs, 0 ];

features = zeros(1,length(Cs));
regLines = zeros(1,length(Cs));

%seppoints = 5:25:length(Cs)-5;
startArea = floor(0.5*length(Cs));
endArea = length(Cs);
pointsToTest = floor((endArea - startArea)/10);

seppoints = startArea:pointsToTest:endArea;
seppoints = [seppoints,endArea];
errors = zeros(1,length(seppoints));

leftFeatures = [0];
rightFeatures = [0];
for i = 1:length(seppoints)
    sep_point = seppoints (i);
    
    left_Segment = Cs(1:sep_point);
    left_Diffs = diffCs(1:sep_point);
    for j=2:length(left_Segment)
        if (strcmp(feature,'densities') == 1)
            leftFeatures = [leftFeatures, trapz(left_Segment(1:j))];
        end
        if (strcmp(feature,'tempo') == 1)
            leftFeatures = [leftFeatures, sum(left_Diffs(1:j) ~= 0)];
        end
    end
    [left_error] = linearRegression(leftFeatures);
    
    right_Segment = Cs(sep_point:end);
    right_Diffs = diffCs(sep_point:end);
    for k=2:length(right_Segment)
        if (strcmp(feature,'densities') == 1)
            rightFeatures = [rightFeatures, trapz(right_Segment(1:k))];
        end
        if (strcmp(feature,'tempo') == 1)
            rightFeatures = [rightFeatures, sum(right_Diffs(1:k) ~= 0)];
        end
    end
    [right_error] = linearRegression(rightFeatures);
    errors(i) = left_error+right_error;
    
    leftFeatures = [0];
    rightFeatures = [0];
end

%what is the best seperation point??
[minvalue,minindex] = min(errors);
sep_point = seppoints(minindex);

%recalculate visualisation-stuff for this seperation point.  just nececary 
%for visualisation
left_Segment = Cs(1:sep_point);
left_Diffs = diffCs(1:sep_point);
for j=2:length(left_Segment)
    if (strcmp(feature,'densities') == 1)
        leftFeatures = [leftFeatures, trapz(left_Segment(1:j))];
    end
    if (strcmp(feature,'tempo') == 1)
        leftFeatures = [leftFeatures, sum(left_Diffs(1:j) ~= 0)];
    end
end
[left_error,left_regLine] = linearRegression(leftFeatures);

right_Segment = Cs(sep_point:end);
right_Diffs = diffCs(sep_point:end);
for k=2:length(right_Segment)
    if (strcmp(feature,'densities') == 1)
        rightFeatures = [rightFeatures, trapz(right_Segment(1:k))];
    end
    if (strcmp(feature,'tempo') == 1)
        rightFeatures = [rightFeatures, sum(right_Diffs(1:k) ~= 0)];
    end
end
[right_error,right_regLine] = linearRegression(rightFeatures);


features(1:sep_point) = leftFeatures;
features(sep_point:end) = rightFeatures;
regLines(1:sep_point) = left_regLine;
regLines(sep_point:end) = right_regLine;

end

