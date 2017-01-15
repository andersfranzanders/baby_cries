function [ x_seg,c, segmentLength, avgBurstLength, burstVariance, avgVtoPFraction, VtoPVariance, gainVariance] = produceConstantSegment_words(crySet,Fs,segmentLength_w, avgBurstLength_w, burstVariance_w, avgVtoPFraction_w, VtoPVariance_w, gainVariance_w)

segmentLength = 0;
switch segmentLength_w
    case 's'
        segmentLength = 5;
    case 'm'
        segmentLength = 10;
    case 'l'
        segmentLength = 20;
    case 'xl'
        segmentLength = 40;
    case 'xxl'
        segmentLength = 60;
    case 'xxxl'
        segmentLength = 140;
    otherwise
        error('segmentLength must be \in {s, m, l,xl}') ;
end 

avgBurstLength = 0; 
switch avgBurstLength_w
    case 'xs'
        avgBurstLength = 0.5;
    case 's'
        avgBurstLength = 1;
    case 'm'
        avgBurstLength = 2;
    case 'l'
        avgBurstLength = 3;
    case 'xl'
        avgBurstLength = 4;    
    case 'xxl'
        avgBurstLength = 6;
    otherwise
        error('avgBurstLength must be \in {xs, s, m, l,xl,xxl}') ;
end 

burstVariance = 0; 
switch burstVariance_w
    case 'zero'
        burstVariance = 0;
    case 's'
        burstVariance = 0.1;
    case 'm'
        burstVariance = 0.2;
    case 'l'
        burstVariance = 0.5;
    case 'xl'
        burstVariance = 0.9;
    otherwise
        error('burstVariance must be \in {zero,x, m, l, xl}') ;
end 

avgVtoPFraction = 0; 
switch avgVtoPFraction_w
    case 's'
        avgVtoPFraction = 0.2;
    case 'm'
        avgVtoPFraction = 0.5;
    case 'l'
        avgVtoPFraction = 0.8;
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
    otherwise
        error('gainVariance must be \in {zero,s, m, l}') ;
end 



[x_seg,c] = produceConstantSegment(crySet,Fs,segmentLength, avgBurstLength, burstVariance, avgVtoPFraction, VtoPVariance, gainVariance);

end