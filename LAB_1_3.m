img = imread('C:\Users\dell\Downloads\lenna.jpg'); 
imgHalf=imresize(img, 0.5,"bicubic"); 
[R, C, N] = size(imgHalf);                  % Get image size (R: row, C: column, N: channels)
imgGray = rgb2gray(imgHalf);                % Get image grayscale
%% Display
figure;
set(surface, 'Linestyle', 'none');          % Better visualization
colormap(gray(256));                        % Change figure's colormap to gray
surf(1:C, 1:R, imgGray);                    % Plot 3D image with surf(X, Y, Z) where:
                                            % X represents image's columns
                                            % Y represents image's rows
                                            % Z represents image's grayscale to coordinate (x, y)