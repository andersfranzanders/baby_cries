function displaySpecto( specto , maxFreq)

temp1 = flipud(specto');
[rows,cols] = size(temp1);
temp2 = temp1(floor(maxFreq*rows):end, :);

[rows,cols] = size(temp2);


temp2 = log(temp2+1);
I = mat2gray(temp2);
stretch = 2*rows/cols;
stretchedImage = imresize(I, [rows (cols*stretch)]);
subplot(4,1,[3,4]);
imshow(stretchedImage)

end

