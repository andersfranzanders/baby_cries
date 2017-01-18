function [ color ] = mapValueToCombiAmpelColor(values,hueMin,hueMax,satMin,satMax )


if values(1) < hueMin
    values(1) = hueMin;
end
if values(1) > hueMax
   values(1) = hueMax; 
end
if values(2) < satMin
    values(2) = satMin;
end
if values(2) > satMax
   values(2) = satMax; 
end



green_grad = 120;
norm_hue_value = ( (values(1)-hueMin)/(hueMax-hueMin) );
norm_hue_value = 1-norm_hue_value;
this_grad = norm_hue_value*green_grad;

norm_sat_value = ( (values(2)-satMin)/(satMax-satMin) );
norm_sat_value = 1-norm_sat_value;

tempRGB = hsv2rgb(this_grad/360,norm_sat_value,1);
color = zeros(1,3);
color(1) = tempRGB(1,1,1);
color(2) = tempRGB(1,1,2);
color(3) = tempRGB(1,1,3);

end

