fs = 44100;

f = 300;
set(gcf,'color','w');

impulstrain = zeros(1*fs,1);
sound(impulstrain,fs);

noise = wgn(fs,1,0.5);



for i = 1:length(impulstrain)
   if mod(i,floor(fs/f)) == 0 
        impulstrain(i+2) = 0.0;
        impulstrain(i+1) = 0.5;
        impulstrain(i) = 1;
        impulstrain(i-1) = 0.95;
        impulstrain(i-2) = 0.9;
        impulstrain(i-3) = 0.8;
        impulstrain(i-4) = 0.7;
        impulstrain(i-5) = 0.6;
        impulstrain(i-6) = 0.4;
        impulstrain(i-7) = 0.3;
        impulstrain(i-8) = 0.2;
        impulstrain(i-9) = 0.1;
        impulstrain(i-10) = 0.0;
   end
end

%x = impulstrain(1:1*fs);
x = noise;
%support = 1:length(x);
%plot(support(1:700)/fs,x(1:700), 'Color', 'k');
%axis([0, 0.016 , 0, 1.3])

%plot(support(1:700)/fs,noise(1:700), 'Color', 'k');
%plot(x);

%Y = abs(fft(x));
Y = abs(fft(noise));
support = 0:length(Y)-1;
support = support*fs/length(Y);
spec = Y(1: floor(0.5*(length(Y)/2 + 1)) );
%plot(support(1:length(spec)),spec, 'Color','k');

B = [ 1,  -1.28317,  0.556181 ];
A = [ 1, -5.43366,  14.3935, -24.0605,  27.5971, -22.1768,  12.2023, -4.21549, 0.702507 ];
filteredX = filter(B,A,x);
%sound(filteredX,fs);

B2 = 1;
A2 = [ 1, -0.0158416,   0.554424 ];
filteredX = filter(B2,A2,filteredX);


filteredY = abs(fft(filteredX));
filteredY = filteredY(1: floor(0.5*length(filteredY)/2));
plot(support(1:length(filteredY)),filteredY,'Color','k');


%[h,w] = freqz(B,A,2^11);
%[h,w] = freqz(B2,A2,2^11);
%h = abs(h(1:0.5*length(h)));
%support = 0:length(Y)-1;
%support = support*fs/(length(Y)*2-1);
%plot(support(1:length(h)),h,'Color','k');
