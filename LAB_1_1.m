%% Input processing
img512 = imread('lenna.jpg');                                       % Load image
img128 = imresize(img512, 0.25,"bicubic");                          % Resize image to 128x128

%% Output
imgGray = rgb2gray(img128);                                         % Convert image to grayscale
outImg = zeros([1024 1024]);                                        % Create the final image

%% Output processing
outImg(:, :) = 32;                                                  % Fill the first square with grayscale 32
outImg(512-256+1:512+256, 512-256+1:512+256) = 64;                  % Fill the second square with grayscale 64
outImg(512-128+1:512+128, 512-128+1:512+128) = 128;                 % Fill the third square with grayscale 128
outImg(512-64+1:512+64, 512-64+1:512+64) = imgGray(1:128, 1:128);   % Fill the last square with the picture

%% Display
imshow(uint8(outImg));                                              % Show the final image
