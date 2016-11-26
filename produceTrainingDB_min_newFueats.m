pathToTrainingset = '../audiobase/truncated/real_noise/50+3db/';
training_set = getAllFileNamesInDirectory(pathToTrainingset);
noiseLevel = '50+3db';
outPath = 'matrix_out/newMins_newFeats/training_arff/';

featureMatrix = zeros(1,10+9);

%Plot Input Signal
figure('Name', 'Signal','position', [100, 100, 700, 700])

for i = 1:length(training_set)
    training_set{i}
    [x,Fs,classSignal] = readInAudioAndClassification(strcat(pathToTrainingset,training_set{i}));

    
    [support,M] = windowAndExtractFeatures_newFeats( x,classSignal,25,Fs );
    M = addMinsToM_new(M, 3, 25);

    featureMatrix = cat(1,featureMatrix,M);
end

featureMatrix = tripleNegativeClasses(featureMatrix);

dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_all.arff'),featureMatrix(:,[1,10,2,11,3,12,4,13,5,14,6,15,7,16,8,17,9,18,19]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_TD.arff'),featureMatrix(:,[1,10,2,11,19]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_FD.arff'),featureMatrix(:,[3,12,4,13,5,14,19]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_CeD.arff'),featureMatrix(:,[6,15,7,16,19]));
dlmwrite(strcat(outPath,'/featureMatrix_',noiseLevel,'_CoD.arff'),featureMatrix(:,[8,17,9,18,19]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_TD+FD.arff'),featureMatrix(:,[1,10,2,11,3,12,4,13,5,14,19]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_TD+CeD.arff'),featureMatrix(:,[1,10,2,11,6,15,7,16,19]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_TD+CoD.arff'),featureMatrix(:,[1,10,2,11,8,17,9,18,19]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_FD+CeD.arff'),featureMatrix(:,[3,12,4,13,5,14,6,15,7,16,19]));
dlmwrite(strcat(outPath,'featureMatrix_',noiseLevel,'_FD+CoD.arff'),featureMatrix(:,[3,12,4,13,5,14,8,17,9,18,19]));