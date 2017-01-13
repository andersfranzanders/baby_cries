function [ color ] = mapValueToAmpelColor(value,minValue,maxValue,isOneGood )


green_grad = 120;

norm_value = ( (value-minValue)/(maxValue-minValue) );
if ~isOneGood
    norm_value = 1-norm_value;
end

this_grad = norm_value*green_grad;

tempRGB = hsv2rgb(this_grad/360,0.6,1);
color = zeros(1,3);
color(1) = tempRGB(1,1,1);
color(2) = tempRGB(1,1,2);
color(3) = tempRGB(1,1,3);

end

