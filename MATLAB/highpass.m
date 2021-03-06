clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures.
clear;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
fontSize = 20;
% Read in a standard MATLAB gray scale demo image.
%folder = fullfile(matlabroot, '\toolbox\images\imdemos');
%baseFileName = 'cameraman.tif';
folder = 'C:/Users/karat/Downloads/TDI Teoria/imagenes/';
baseFileName = 'animalesSalvajes.jpg';
%grayImage = imread('limite100.jpg');

% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
  % Didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
grayImage = imread(fullFileName);
grayImage = rgb2gray(grayImage);
% Get the dimensions of the image.  numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Position', get(0,'Screensize')); 
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 
% Filter 1
kernel1 = -1 * ones(3)/9;
kernel1(2,2) = 8/9;
% Filter the image.  Need to cast to single so it can be floating point
% which allows the image to have negative values.
filteredImage = imfilter(single(grayImage), kernel1);
% Display the image.
subplot(2, 2, 2);   
imshow(filteredImage, []);
title('Filtered Image', 'FontSize', fontSize);
% Filter 2
kernel2 = [-1 -2 -1; -2 12 -2; -1 -2 -1]/16;
% Filter the image.  Need to cast to single so it can be floating point
% which allows the image to have negative values.
filteredImage = imfilter(single(grayImage), kernel2);
% Display the image.
subplot(2, 2, 3);
imshow(filteredImage, []);
title('Filtered Image', 'FontSize', fontSize);