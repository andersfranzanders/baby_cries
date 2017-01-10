function [ x, c, Fs ] = produceTimeAnalysisTestSignal( pathToCrySet, pathToNoiseSignal,aimSNRinDB )

%read in all the cry segments into a set.
cry_set_name = getAllFileNamesInDirectory(pathToCrySet);

if length(cry_set_name) > 1
   error('more than one cry signal in folder!'); 
end
[audio,samplingrate] = readInAudio(strcat(pathToCrySet,cry_set_name{1}));
Fs = samplingrate;
crySignal = normalize(audio');


x = [];
c = [];

%begin cry with random pause
firstPause = zeros(1, floor(0.5*Fs));
x = [firstPause,x];
c = [firstPause,c];

%%% First: Density stays the same, tempo rises. 
[ x_s,c_s ] = produceTimeAnalysisSegment(crySignal,Fs,3, 3, 3, 3, 3  );
x = [x,x_s];
c = [c,c_s];

[ x_s,c_s ] = produceTimeAnalysisSegment(crySignal,Fs,5, 1.5, 1.5, 1.5,1.5 );
x = [x,x_s];
c = [c,c_s];

[ x_s,c_s ] = produceTimeAnalysisSegment(crySignal,Fs,8, 0.5,0.5,0.5,0.5 );
x = [x,x_s];
c = [c,c_s];

[ x_s,c_s ] = produceTimeAnalysisSegment(crySignal,Fs,8, 0.2,0.2,0.2,0.2);
x = [x,x_s];
c = [c,c_s];


%some pause
somePause = zeros(1, floor(8*Fs));
x = [x,somePause];
c = [c,somePause];

%tempo stays the same, densitie falls
[ x_s,c_s ] = produceTimeAnalysisSegment(crySignal,Fs,5, 2.5,2.5,0.5,0.5);
x = [x,x_s];
c = [c,c_s];

[ x_s,c_s ] = produceTimeAnalysisSegment(crySignal,Fs,5, 1.5,1.5,1.5,1.5);
x = [x,x_s];
c = [c,c_s];

[ x_s,c_s ] = produceTimeAnalysisSegment(crySignal,Fs,5, 0.5,0.5,2.5,2.5);
x = [x,x_s];
c = [c,c_s];



%read in noise signal and concatinated it to match the cry signals size
noise = readInAudio(pathToNoiseSignal);
noise = noise';
concatNoiseSignal = [];
while length(concatNoiseSignal) < length(x)
    concatNoiseSignal = [noise, concatNoiseSignal];
end

concatNoiseSignal = concatNoiseSignal(1:length(x));

x = addNoiseToCry(x, concatNoiseSignal, aimSNRinDB);

end

