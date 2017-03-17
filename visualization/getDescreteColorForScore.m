function [ color ] = getDescreteColorForScore( pain_score,max_score )

m = 255;

green = [110/m;250/m;86/m];
lightgreen = [194/m;246/m;58/m];
yellow = [255/m;240/m;0/m];
orange = [255/m;157/m;26/m];
red = [243/m;45/m;22/m];

switch max_score
    case 0
        color = green;
    case 1
        switch pain_score
            case 0
                color = green;
            case 1
                color = red;
        end
    case 2
        switch pain_score
            case 0
                color = green;
            case 1
                color = yellow;
            case 2
                color = red;
        end
    case 3
        switch pain_score
            case 0
                color = lightgreen;
            case 1
                color = yellow;
            case 2
                color = orange;
            case 3
                color = red;
        end
    case 4
        switch pain_score
            case 0
                color = green;
            case 1
                color = lightgreen;
            case 2
                color = yellow;
            case 3
                color = orange;
            case 4
                color = red;
        end
end

end

