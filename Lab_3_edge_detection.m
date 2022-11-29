close all;
%% Step 1: load the image and artificially add some noise
image = double(imread("ic2.tif"));
% Noise Creation
b=(randn(256,256)*15);
% Adding noise to the previous image
c=image+b;
%% Step 2: de-noise the image
% average filtering
p=fspecial("average",[5 5]);
pc=filter2(p,c);
% imshow(uint8(pc));

% median filtering
m=medfilt2(c,[5 5]);
% imshow(uint8(m));

% weiner filtering
K = wiener2(c,[3 3]);
% imshow(uint8(K));

%Plotting all three filters
figure();
subplot(1,3,1),imshow(uint8(pc));
title('Average filter');
subplot(1,3,2),imshow(uint8(m));
title('Median filter');
subplot(1,3,3),imshow(uint8(K));
title('Wiener filter');
sgtitle('Figure 1 Expected output for Step 2');
%% Step 3: highlight edges
fx=[-1 0 1];
fy= fx';

Gx=imfilter(m,fx,"symmetric");
Gy=imfilter(m,fy,"symmetric");
G=sqrt(Gx.^2+Gy.^2)/255;

k= graythresh(G);
BW = imbinarize(G,k);

BW2 = bwmorph(BW,'thin');

subplot(2,3,1), imshow(Gx,[]); title('Horizontal Gradient');
subplot(2,3,2), imshow(Gy,[]); title('Vertical Gradient');
subplot(2,3,3), imshow(G); title('Gradient');
subplot(2,3,5), imshow(BW); title('Gradient w/ threshold');
subplot(2,3,6),imshow(BW2); title('Gradient w/ morphological');
sgtitle('Edge Detection');
%% Laplacian
Laplacian=[0 1 0; 1 -4 1; 0 1 0];
lap = imfilter(m, Laplacian, 'symmetric');
imshow(lap,[]);
title('zero crossings of the Laplacian')
%% Canny edge detection
canny = edge(m,"canny");
imshow(canny);
title('Canny edge detector');
%% Step 4: compute the Radon transform
R = radon(BW2);
imshow(R,[]);
colormap("jet");
title("Figure 3 Expected output of computation of the Radon transform");
%% Step 5: choose points in Radon transform and observe associated lines
interactiveLine(BW2 ,R ,5);
% Step 6: find the image orientation and rotate it
V = max(R);
V1 = V(1:90)+V(91:180);
figure;
subplot(1,2,1), plot(V);
colormap("jet"); title("V plot");
subplot(1,2,2), plot(V1); title("V(1:90)+V(91:180) plot")
[val, idx] = max(V1);
J = imrotate(m,-idx);
figure;
subplot(1,2,2), imshow(J,[]), title("Registered Image");
subplot(1,2,1), imshow(uint8(image)), title("Original image");
sgtitle("Figure 4 expected final output");

function interactiveLine(imgEdge,imgRadon,N)
%FUNCTION interactiveLine(imgEdge,imgRadon,N);
%   Parameters:
%     - imgEdge: Edge image
%     - imgRadon: Radon transform of imgEdge
%     - N: Number of lines to be drawn

% Display the radon transform
figure;
imshow(imgRadon,[]);
colormap(jet);

% Click some points
disp('Select as many points as required')
[X,Y] = ginput(N);

% Display crosses at selected points
hold on;
plot(X,Y,'mx');
hold off;

% Obtain some dimensions
[h, w]= size(imgEdge);
[hr, wr] = size(imgRadon);

% Display the edge image with overlaid lines
figure;
imshow(imgEdge,[]);
hold on;
for i=1:N
    [LX, LY] = tracedroite(w,h,wr,hr,X(i),Y(i));
    plot(LX,LY);
end
hold off;
end

function [X, Y] = tracedroite(w, h, wr, hr, x, y)
t = -hr:hr;
a = (x/double(wr))*pi;
cs = cos(a);
sn = sin(a);
d = y-hr/2;
X = w/2 + cs*d - sn*t;
Y = h/2 - sn*d - cs*t;
end
%% Question 1
% CHOICE OF FILTER: MEDIAN FILTER

% Median filter is useful in preserving edges while reducing noise (image smoothing)
% It is very effective in removing the impulse noise, the "salt and pepper" noise, in the image. 
% Wiener filter: It is very difficult to obtain a perfect restoration for the random nature of the noise.
% Wiener filters are comparatively slow to apply since they require working in the frequency domain.
% In average filtering: When the filter neighbourhood straddles an edge, the filter will interpolate new values for pixels on the edge and so will blur that edge. 
% This may be a problem if sharp edges are required in the output.

%% Question 2
% CHOICE OF EDGE DETECTION: MORPHOLOGICAL OPERATION ON GRADIENT
% edges in image are where the pixel intensities largely change and the
% gradient will detect this large change.
% each pixel value (typically non-negative) 
% indicates the contrast intensity in the close neighborhood of that pixel.
% the image has been enhanced in our choice and the edges can be detected.
%% Question 3
% Calculating Radon transform of a line and a point
% We have taken a line and a point image and calculated the radon transform.
%% CODE
%{
i1=double(imread("vertical-line.jpg"));
i2=double(imread("point_simplepoint.png"));
i=rgb2gray(i1);
j=rgb2gray(i2);
m1=medfilt2(i,[3 3]);
m2=medfilt2(j,[3 3]);
fx1=[-1 0 1];
fy1=fx1';
Gx1=imfilter(m1,fx1,"symmetric");
Gy1=imfilter(m1,fy1,"symmetric");
G1=sqrt(Gx1.^2+Gy1.^2)/255;
Gx2=imfilter(m2,fx1,"symmetric");
Gy2=imfilter(m2,fy1,"symmetric");
G2=sqrt(Gx2.^2+Gy2.^2)/255;
k1= graythresh(G1);
BW1 = imbinarize(G1,k1);
BW2_1 = bwmorph(BW1,'thin');
R1=radon(BW2_1);
k2= graythresh(G2);
BW2 = imbinarize(G2,k2);
BW2_1_2 = bwmorph(BW2,'thin');
R2=radon(BW2_1_2);
subplot(1,2,1),imshow(log(1+abs(R1)),[]), title("Radon on Line Image - Radon's logarithm");
subplot(1,2,2),imshow(R2,[]), title("Radon on Point Image");
sgtitle("Radon Transform Results");
colormap("parula");
%}
%% How does the Radon transform relate to the Hough transform for lines?
% When we plot the hough transformation of the same image and compare it with the radon transformation, 
% When you select the accumulation point for both Hough and radon, it will give us an edge in the original image
% The only difference is that, hough transform appears to be discretisation of the radon transform.
%% Code for Hough and Radon transform on Lines
%{
ix=double(imread("vertical-line.jpg"));
i=rgb2gray(ix);
m1=medfilt2(i,[3 3]);
fx1=[-1 0 1];
fy1=fx1';
Gx1=imfilter(m1,fx1,"symmetric");
Gy1=imfilter(m1,fy1,"symmetric");
G1=sqrt(Gx1.^2+Gy1.^2)/255;
k1= graythresh(G1);
BW1 = imbinarize(G1,k1);
BW2 = bwmorph(BW1,'thin');
R2=hough(BW2);
R1=radon(BW2);
subplot(1,2,1),imshow(log(abs(1+R2)),[]);
title("Hough Transform");
subplot(1,2,2),imshow(log(abs(1+R1)),[]);
title("Radon Transform");
colormap("parula");
%}
%% Explain why the sum over any column of the Radon transform is always the same.
% The sum over any column represents the total sum of the image intensity along a angle 
% which is constant with respect to the angle at which we calculate. 
% Thus, the sum over any column of the Radon transform is always the same.
%% It is better to look for the maximum value of V(1:90)+V(91:180).Why?
% It is better to consider the maximum value of V(1:90) and V(91:180)
% as V(1:90) represents the angle with most significant vertical line  
% and V(91:180) represents the angle with most significant horizontal line
% to rotate the image, it is necessary to consider both the lines and
% rotate the image using the corresponding angle. And we also observe
% in our image that the angles are same in both cases.
%% Bonus Question
% Gradually increase the strength of the noise in Step
% 1 and observe when the rotation angle fails to be estimated correctly. For this noisy image, can you
% adjust the parameters of your system to estimate the rotation angle correctly again? Explain the
% adjustments required.

% Answer
% We increased the noise by 50 and our model failed to rotate the image. 
% Then we decreased the neighbouring size of the median filter from [5 5] to [3 3]
% It is significance that the angle of rotation should be 88 for 
% our image,so as we increase the noise of the image, our system will fail to detect the 
% angle correctly after a specific noise value, so as a result to that, we
% aimed to decrease the intensity of the median filter(i.e instead of 3×3 we can try 5×5 and this will 
% go proportional with the noise quantity) since the program failed to detect the angle correctly when
% noise was 50 and median filter intesity is 5×5, we will decrease now the value of the median filter
% to 3×3 and it should detect the angle 88 correctly.
%% Code for bonus question
%{
close all
image = double(imread("ic2.tif"));
% Noise Creation
% increased noise
b=(randn(256,256)*50);  
c=image+b;
% Median filter
m=medfilt2(c,[3 3]);
% imshow(uint8(m));
% Gradient 
fx=[-1 0 1];
fy= fx';
Gx=imfilter(m,fx,"symmetric");
Gy=imfilter(m,fy,"symmetric");
G=sqrt(Gx.^2+Gy.^2)/255;
k= graythresh(G);
BW = imbinarize(G,k);
BW2 = bwmorph(BW,'thin');
% Radon transform
R = radon(BW2);
interactiveLine(BW2 ,R ,5);
V = max(R);
V1 = V(1:90)+V(91:180);
figure;
subplot(1,2,1), plot(V);
colormap("jet"); title("V plot");
subplot(1,2,2), plot(V1); title("V(1:90)+V(91:180) plot")
[val, idx] = max(V1);
J = imrotate(m,-idx);
figure;
subplot(1,2,2), imshow(J,[]), title("Registered Image");
subplot(1,2,1), imshow(uint8(image)), title("Original image");
sgtitle("Figure 4 expected final output");

function interactiveLine(imgEdge,imgRadon,N)
%FUNCTION interactiveLine(imgEdge,imgRadon,N);
%   Parameters:
%     - imgEdge: Edge image
%     - imgRadon: Radon transform of imgEdge
%     - N: Number of lines to be drawn

% Display the radon transform
figure;
imshow(imgRadon,[]);
colormap(jet);

% Click some points
disp('Select as many points as required')
[X,Y] = ginput(N);

% Display crosses at selected points
hold on;
plot(X,Y,'mx');
hold off;

% Obtain some dimensions
[h, w]= size(imgEdge);
[hr, wr] = size(imgRadon);

% Display the edge image with overlaid lines
figure;
imshow(imgEdge,[]);
hold on;
for i=1:N
    [LX, LY] = tracedroite(w,h,wr,hr,X(i),Y(i));
    plot(LX,LY);
end
hold off;
end

function [X, Y] = tracedroite(w, h, wr, hr, x, y)
t = -hr:hr;
a = (x/double(wr))*pi;
cs = cos(a);
sn = sin(a);
d = y-hr/2;
X = w/2 + cs*d - sn*t;
Y = h/2 - sn*d - cs*t;
end
%}