pathToMatrixes = 'vad/matrix_out/2000/box_evaluation/';

modelNames = {'CeD002','CeD003'};
testSet = '7db_test';

globalM = [];
for i=1:length(modelNames)
    modelName = modelNames{i}
    filename = (strcat(pathToMatrixes,'eval_',modelName,'-->',testSet,'.txt'));
    M = importdata(filename,' ');

    globalM = [globalM,M];
end
labels = {'Sensitivity','Specificity','Accuracy',...
    'Sensitivity','Specificity','Accuracy'};


figure('Name', 'Evaluation of Cepstral VAD','position', [100, 100, 700, 400])
boxplot(globalM,'Labels',labels)
title(strcat('Testset: SNR with ',testSet));
ylabel('Percent')
set(gca,'FontSize',11,'XTickLabelRotation',90)