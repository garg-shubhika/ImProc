%Shubhika GARG

%linear filtering in the spatial domain
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
p=fspecial("average",[3 3]);
pc=filter2(p,c);

q=fspecial("average",[5 5]);
qc=filter2(q,c);

r=fspecial("average",[7 7]);
rc=filter2(r,c);

%% Output processing
figure();
subplot(2,3,1),imshow(uint8(a));
title('Original image');

subplot(2,3,3),imshow(c,[]);
title('Noisy image');

subplot(2,3,4),imshow(pc,[]);
title('Filtering 3*3');

subplot(2,3,5),imshow(qc,[]);
title('Filtering 5*5');

subplot(2,3,6),imshow(rc,[]);
title('Filtering 7*7');

sgtitle('Average filtering');
%% Solutions
%As the filter size increases, the clarity of the image decreases
%The image becomes more blurry
%The bigger the filter is in te spatial domain, the smaller it is in the
%frequency domain 
