function [ x_seg,c ] = produceAcceleratingSegment_words(crySet,Fs,maxCryEvents_w, startBurstLength_w, burstAcceleration_w, avgVtoPFraction_w, VtoPVariance_w,  gainVariance_w)

maxCryEvents = 0,
switch maxCryEvents_w
    case 's'
        maxCryEvents = 3;
    case 'm'
        maxCryEvents = 6;
    case 'l'
        maxCryEvents = 10;
    otherwise
        error('maxCryEvents must be \in {s, m, l}') ;
end 

startBurstLength = 0; 
switch startBurstLength_w
    case 'xs'
        startBurstLength = 0.5;
    case 's'
        startBurstLength = 1;
    case 'm'
        startBurstLength = 2;
    case 'l'
        startBurstLength = 3;
    case 'xl'
        startBurstLength = 4;
    otherwise
        error('startBurstLength must be \in {xs, s, m, l,xl}') ;
end 

burstAcceleration = 0; 
switch burstAcceleration_w
    case '-l'
        burstAcceleration = 0.5;
    case '-m'
        burstAcceleration = 0.7;
    case '-s'
        burstAcceleration = 0.8;
    case 'zero'
        burstAcceleration = 1;
    case '+s'
        burstAcceleration = 1.3;
    case '+m'
        burstAcceleration = 1.5;
    case '+l'
        burstAcceleration = 2;
    otherwise
        error('burstAcceleration must be \in {-l,-m,-s,zero,s, m, l}') ;
end 

avgVtoPFraction = 0; 
switch avgVtoPFraction_w
    case 's'
        avgVtoPFraction = 0.2;
    case 'm'
        avgVtoPFraction = 0.5;
    case 'l'
        avgVtoPFraction = 0.75;
    otherwise
        error('avgVtoPFraction must be \in {s, m, l}') ;
end 

VtoPVariance = 0; 
switch VtoPVariance_w
     case 'zero'
        VtoPVariance = 0;
    case 's'
        VtoPVariance = 0.1;
    case 'm'
        VtoPVariance = 0.2;
    case 'l'
        VtoPVariance = 0.49;
    case 'xl'
        VtoPVariance = 0.7;
    otherwise
        error('VtoPVariance must be \in {zero,s, m, l,xl}') ;
end 

gainVariance = 0;
switch gainVariance_w
     case 'zero'
        gainVariance = 0;
    case 's'
        gainVariance = 0.1;
    case 'm'
        gainVariance = 0.2;
    case 'l'
        gainVariance = 0.5;
    case 'xl'
        gainVariance = 0.8;
    otherwise
        error('gainVariance must be \in {zero,s, m, l}') ;
end 



[ x_seg,c ] = produceAcceleratingSegment(crySet,Fs,maxCryEvents, startBurstLength, burstAcceleration, avgVtoPFraction, VtoPVariance,  gainVariance);

end