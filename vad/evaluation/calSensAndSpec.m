function [ Sensitivity, Specificity, Accuracy ] = calSensAndSpec( realCs,calCs,numFramesPerWindow )
frames = floor(length(realCs)/numFramesPerWindow);
Sensitivity = zeros(1,frames);
Specificity = zeros(1,frames);
Accuracy = zeros(1,frames);

for i = 1:frames
    window_start = (i-1)*numFramesPerWindow +1;
    window_end = i*numFramesPerWindow;
    realCsWindow = realCs(window_start:window_end);
    calCsWindow = calCs(window_start:window_end);
    
    TP = 0; TN = 0; FP = 0; FN = 0;
    
    for k = 1:length(realCsWindow)
        if realCsWindow(k) == 1 && calCsWindow(k) == 1
            TP = TP + 1;
        end
        if realCsWindow(k) == 0 && calCsWindow(k) == 0
            TN = TN + 1;
        end
        if realCsWindow(k) == 0 && calCsWindow(k) == 1
            FP = FP + 1;
        end
        if realCsWindow(k) == 1 && calCsWindow(k) == 0
            FN = FN + 1;
        end 
    end
    
    
    Sensitivity(i) = TP/(TP+FN);
    Specificity(i) = TN/(TN+FP);
    Accuracy(i) = (TP+TN)/(TP+TN+FP+FN);
    
end

end

