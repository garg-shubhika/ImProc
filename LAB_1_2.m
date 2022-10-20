%% Input loading
img = imread('C:\Users\dell\Downloads\lenna.jpg');                          % Load image
[R, C, N] = size(img);                              % Get image size (R: row, C: column, N: channels)

%% Input processing
imgUD = flipud(img);                                % Flip up/down
imgLR = fliplr(img);                                % Flip left/right
imgUDLR = fliplr(imgUD);                            % Flip up/down then left/right

%% Output
outImg = zeros([2*R 2*C N]);                        % Create final image with all R G B channels to 0 to make next
                                                    % steps easier by only adding one color channel

%% Output processing
outImg(1:R, 1:C, :) = img(:, :, :);                 % Top Left with initial image
outImg(1:R, 1+C:2*C, 3) = imgUD(:, :, 3);           % Top Right with flipped up/down with only blue channel
outImg(1+R:2*R, 1:C, 1) = imgLR(:, :, 1);           % Bottom Left with flipped left/right with red channel
outImg(1+R:2*R, 1+C:2*C, 2) = imgUDLR(:, :, 2);     % Bottom Right with flipped up/down and left/right with only 
                                                    % green channel

%% Display
imshow(uint8(outImg));