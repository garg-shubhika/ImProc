%Shubhika GARG

%non-linear Filtrage
%% Creating a matrix of 256*256 and 64*64 in the centre
a=ones([256 256])*64; %To get gray value of 64
%square area of size 64 and pixel values of 192
a(128-64+1:128+64, 128-64+1:128+64)=a(128-64+1:128+64, 128-64+1:128+64)*3;

%% Creating a noisy image
% % Noise Creation
b=rand(256,256)*255;
% Noise
% Adding noise to the previous image
c=a+b;

%% Creating proper filters
p=medfilt2(c,[3 3]);
q=medfilt2(c,[5 5]);
r=medfilt2(c,[7 7]);
%pc=filter2(p,c);
figure();
subplot(2,3,1),imshow(uint8(a));
title('Original image');

subplot(2,3,3),imshow(c,[]);
title('Image Bruitee');

subplot(2,3,4),imshow(p,[]);
title('Filtrage 3*3');

subplot(2,3,5),imshow(p,[]);
title('Filtrage 5*5');

subplot(2,3,6),imshow(p,[]);
title('Filtrage 7*7');

sgtitle('Median filtering');
% When image is filtered by median filter, the noise is completely ignored, thus the edges remain sharper(less blurry) as compared to average filter.
