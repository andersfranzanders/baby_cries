pathToTrainingset = '../audiobase/truncated/real_noise/50+0db/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);
noiseLevel = '50+0db';
outPath = 'matrix_out/mins/training_arff/';

featureMatrix = zeros(1,11+10);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

for i = 1:length(training_set)
    training_set{i}
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));

    
    [support,M] = windowAndExtractFeatures( x,classSignal,25,Fs );
    M = addMinsToM(M, 3, 25);

    featureMatrix = cat(1,featureMatrix,M);
end

featureMatrix = tripleNegativeClasses(featureMatrix);

dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_all.arff'),featureMatrix);
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_TD.arff'),featureMatrix(:,[1,2,11,12,21]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_FD.arff'),featureMatrix(:,[3,4,5,13,14,15,21]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_CeD.arff'),featureMatrix(:,[6,7,8,16,17,18,21]));
dlmwrite(strcat(outPath,'/featureMatrix_',noiseLevel,'_CoD.arff'),featureMatrix(:,[9,10,19,20,21]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_TD+FD.arff'),featureMatrix(:,[1,2,3,4,5,11,12,13,14,15,21]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_TD+CeD.arff'),featureMatrix(:,[1,2,6,7,8,11,12,16,17,18,21]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_TD+CoD.arff'),featureMatrix(:,[1,2,9,10,11,12,19,20,21]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_FD+CeD.arff'),featureMatrix(:,[3,4,5,6,7,8,13,14,15,16,17,18,21]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_FD+CoD.arff'),featureMatrix(:,[3,4,5,9,10,13,14,15,19,20,21]));