outPath = 'vad/matrix_out/2000/box_evaluation/';
modelFeatures = 'CeD';
modelDB = '002';



testDecibels = {'3db','50db','7db_test'};
for testIndex = 1:length(testDecibels)

    testDB = testDecibels{testIndex};
    pathToTestSet = strcat('../audiobase/truncated/real_noise/',testDB,'/')
    test_set = getAllFileNamesInDirectory(pathToTestSet);

    globalSensitivity = [];
    globalSpecificity = [];
    globalAccuracy = [];

    for i = 1:length(test_set)
        test_set{i}
        [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTestSet,test_set{i}));

        [support,M] = windowAndExtractFeatures_2000( x,classSignal,25,Fs );
        realCs = M(:,end);
        calCs = thresholdFeatures_CeD_002(M);

        [ Sensitivity, Specificity, Accuracy ] = calSensAndSpec( realCs,calCs,100 );

        globalSensitivity = [globalSensitivity,Sensitivity];
        globalSpecificity = [globalSpecificity,Specificity];
        globalAccuracy = [globalAccuracy,Accuracy];
    end
    
    matrix = zeros(length(globalSensitivity),3);
    matrix(:,1) = globalSensitivity;
    matrix(:,2) = globalSpecificity;
    matrix(:,3) = globalAccuracy;
    matrix

    filename = strcat('eval_',modelFeatures,modelDB,'-->',testDB);
    dlmwrite(strcat(outPath,filename,'.txt'),matrix,'delimiter',' ');
end
    
    