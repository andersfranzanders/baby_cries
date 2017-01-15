function [ x, c, Fs,segmentMetaData ] = timeAnalysis_evaluationUseCase( pathToCrySet, pathToNoiseSignal,aimSNRinDB )

%read in all the cry segments into a set.
cry_set_names = getAllFileNamesInDirectory(pathToCrySet);
Fs = 0;
crySet = [];
for i = 1:length(cry_set_names)
    [audio,samplingrate] = readInAudio(strcat(pathToCrySet,cry_set_names{i}));
    Fs = samplingrate;
    audio = normalize(audio');
    crySet = [{audio}; crySet];
end

segmentMetaData =[];
x = [];
c = [];

%begin cry with random pause
firstPause = zeros(1, floor(0.5*Fs));
x = [firstPause,x];
c = [firstPause,c];


%%% First thing
[ x_seg,c_seg, segmentLength, avgBurstLength, burstVariance, avgVtoPFraction, VtoPVariance, gainVariance ] ...
    = produceConstantSegment_words(crySet,Fs,'xl', 'l', 'zero', 'l', 'zero', 'm');
x = [x,x_seg];
c = [c,c_seg];
segmentMetaData = [segmentMetaData; segmentLength, avgBurstLength, burstVariance, avgVtoPFraction, VtoPVariance, gainVariance];

%%% loooong pause
pause = zeros(1, floor( 30 *Fs));
x = [x,pause];
c = [c,pause];

%%% First second
[ x_seg,c_seg, segmentLength, avgBurstLength, burstVariance, avgVtoPFraction, VtoPVariance, gainVariance ]  ...
    = produceConstantSegment_words(crySet,Fs,'xl', 'm', 'xl', 'm', 'zero', 'l');
x = [x,x_seg];
c = [c,c_seg];
segmentMetaData = [segmentMetaData; segmentLength, avgBurstLength, burstVariance, avgVtoPFraction, VtoPVariance, gainVariance];

%%% loooong pause
pause = zeros(1, floor( 10 *Fs));
x = [x,pause];
c = [c,pause];

%read in noise signal and concatinated it to match the cry signals size
noise = readInAudio(pathToNoiseSignal);
noise = noise';
concatNoiseSignal = [];
while length(concatNoiseSignal) < length(x)
    concatNoiseSignal = [noise, concatNoiseSignal];
end

concatNoiseSignal = concatNoiseSignal(1:length(x));

x = addNoiseToCry_noPauses(x, c, concatNoiseSignal, aimSNRinDB);
segmentMetaData = segmentMetaData';

end



