function stringList = getAllFileNamesInDirectory(pathToTrainingset)

listing = dir(pathToTrainingset);
stringList = [];
for i = 1:length(listing)
    file  = listing(i);
    fileName = file.name();
    if length(fileName) > 4
        if strcmp(fileName(length(fileName)-2:end),'wav')
            stringList = [{fileName(1:end-4)}, stringList];
        end
    end
    
end
