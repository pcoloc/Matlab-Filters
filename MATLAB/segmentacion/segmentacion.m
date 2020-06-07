clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 25;
%===============================================================================
% Get the name of the image the user wants to use.
folder = 'C:/Users/karat/Downloads/TDI Teoria/imagenes';
baseFileName = 'limite100.jpg';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
%===============================================================================
% Read in a demo image.
grayImage = imread(fullFileName);
% Get the dimensions of the image.
% numberOfColorChannels should be = 1 for a gray scale image, and 3 for an RGB color image.
[rows, columns, numberOfColorChannels] = size(grayImage);
if numberOfColorChannels > 1
  % It's not really gray scale like we expected - it's color.
  % Use weighted sum of ALL channels to create a gray scale image.
  grayImage = rgb2gray(grayImage);
  % ALTERNATE METHOD: Convert it to gray scale by taking only the green channel,
  % which in a typical snapshot will be the least noisy channel.
  % grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the image.
subplot(2, 2, 1);
imshow(grayImage, []);
axis on;
axis image;
caption = sprintf('Original Gray Scale Image');
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
drawnow;
hp = impixelinfo();
% Set up figure properties:
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Get rid of tool bar and pulldown menus that are along top of figure.
% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')
drawnow;
% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(grayImage);
subplot(2, 2, 2); 
bar(grayLevels, pixelCount); % Plot it as a bar chart.
grid on;
title('Histogram of original image', 'FontSize', fontSize, 'Interpreter', 'None');
xlabel('Gray Level', 'FontSize', fontSize);
ylabel('Pixel Count', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.
% Binarize the image by thresholding.
mask = grayImage < 125;
% Display the mask image.
subplot(2, 2, 3);
imshow(mask);
axis on;
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
title('Binary Image Mask', 'fontSize', fontSize);
drawnow;
% Get rid of blobs touching the border.
mask = imclearborder(mask);
% Extract just the largest blob.
mask = bwareafilt(mask, 1);
% Display the mask image.
subplot(2, 2, 4);
imshow(mask);
axis on;
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
title('Lobster-only Mask', 'FontSize', fontSize);
drawnow;
% Get rid of black islands (holes) in struts without filling large black areas.
subplot(2, 2, 4);
mask = ~bwareaopen(~mask, 1000);
imshow(mask);
axis on;
axis image; % Make sure image is not artificially stretched because of screen's aspect ratio.
title('Final Cleaned Mask', 'FontSize', fontSize);
drawnow;