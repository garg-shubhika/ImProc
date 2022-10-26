%Shubhika GARG

%% Computing fourier transform of the image
img=imread('lenna.jpg');
im=rgb2gray(img);

a=fft2(im); 
%fourier transform of the image
b=fftshift(a);
% shift to get the spectrum in the middle

ab=log(1+abs(b));
%to convert to real, use absolute function and as value is low using log,
%adding 1 to eliminate the 0s
%% Applying low-pass filter using function freqLPF()
[R, C, N]= size(im);
% disp([R C N]); [512 512 1]

spectrum = fftshift(fft2(im));

mask1 = freqLPF([R C],0.2);
mask2 = freqLPF([R C],0.05);
mask3 = freqLPF([R C],0.02);
% fc=0.2,0.05,0.02
%% Computing the filtered spectrums
filter_spectrum_1 = spectrum .* mask1;
filter_spectrum_2 = spectrum .* mask2;
filter_spectrum_3 = spectrum .* mask3;

%taking logs of the absolute of the filtered spectrum and adding 1
s1=log(1+abs(filter_spectrum_1));
s2=log(1+abs(filter_spectrum_2));
s3=log(1+abs(filter_spectrum_3));

%inverse zero frequency shift
x=ifftshift(filter_spectrum_1);
y=ifftshift(filter_spectrum_2);
z=ifftshift(filter_spectrum_3);

%2-D inverse fast Fourier transform
%filtered images
p = ifft2(x);
q = ifft2(y);
r = ifft2(z);
%% Output processing
figure;
%subplot(m,n,p) divides the current figure into an m-by-n grid 
%and creates axes in the position specified by p

subplot(2,4,1), imshow(im); 
title("Original image");
subplot(2,4,5), imshow(ab, []); 
title("FT Original");

%fc=0.2
subplot(2,4,2), imshow(abs(p), []);
title('Filtered image (fc=0.2)');
subplot(2,4,6), imshow(s1,[]);
title('Filter spectrum (fc=0.2)');

%fc=0.05
subplot(2,4,3), imshow(abs(q),[]);
title('Filtered image (fc=0.05)');
subplot(2,4,7),imshow(s2,[]);
title('Filter spectrum (fc=0.05)');

%fc=0.02
subplot(2,4,4), imshow(abs(r),[]);
title('Filtered image (fc=0.02)');
subplot(2,4,8),imshow(s3,[]);
title('Filter spectrum (fc=0.02)');
sgtitle('Low-pass filtering');
%% freqLPF Function
function mask = freqLPF(dim,cutOut)
%dim: is an array containing output mask’s dimensions
m = min(dim);
mask = zeros(dim(1),dim(2));
xmin = -dim(2)/2;
ymax = dim(1)/2;
[X,Y] = meshgrid(xmin:xmin+dim(2)-1,...
ymax:-1:ymax-dim(1)+1);
R = sqrt((X/m).^2+(Y/m).^2);
indices = R<cutOut;
mask(indices) = 1;
end
%% Solutions of the questions
% a) The geometrical shape of the filter is a circle
% b) cutOut is the frequency cut off of the filter, 
%    its directly proportional to the circle's radius.
% c) For creating a high pass filter, the radius of the circle must be more than the defined frequency. 
%    It can be achieved by changing "indices = find(R<cutOut);" to "indices = find(R>cutOut);" in the function "freqLPF".
