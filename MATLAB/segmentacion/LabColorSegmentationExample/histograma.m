clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
imtool close all;  % Close all imtool figures if you have the Image Processing Toolbox.
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;

% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		% User said No, so exit.
		return;
	end
end

% Read in a standard MATLAB gray scale demo image.
%%baseFileName = 'limite100.jpg';
folder = 'C:/Users/karat/Downloads/TDI Teoria/imagenes';
%fullFileName = fullfile(folder, baseFileName);
button = menu('Use which demo image?', 'Limite 100', 'Bicis', 'Limite 90', 'Señal LEtras', 'adelantarDanyada');
if button == 1
	baseFileName = 'limite100.jpg';
elseif button == 2
	baseFileName = 'bicis.jpg';
elseif button == 3
	baseFileName = 'limite90_3.jpg';
elseif button == 4
	baseFileName = 'senalLetrs.jpg';
else
	baseFileName = 'adelantarDanyada.jpg';
end

% Read in a standard MATLAB gray scale demo image.
%folder = fullfile(matlabroot, '\toolbox\images\imdemos');
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
	% File doesn't exist -- didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
colorImage = imread(fullFileName);
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	 grayImage = grayImage(:, :, 2); % Take green channel.
end

% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Foto original en Blanco y Negro', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off') 

% Just for fun, let's get its histogram and display it.
[pixelCount, grayLevels] = imhist(grayImage);
subplot(2, 2, 2);
bar(pixelCount);
title('Histogram of gray image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.
grid on;

% Compute the sharpened image when you can get by using imfilter or conv2 and the
% kernel [-1,-1,-1;-1,8,-1;-1,-1,-1], or else if you have the Laplacian already,
% simply add the original image to the laplacianImage.
%sharpenedImage = double(grayImage) + laplacianImage;
 
% Display the image.
subplot(2, 2, 3);
imshow(colorImage, []);
title('Imagen Color', 'FontSize', fontSize);

% Just for fun, let's get its histogram and display it.
[pixelCount, colorLevels] = imhist(colorImage);
subplot(2, 2, 4);
bar(pixelCount);
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 colorLevels(end)]); % Scale x axis manually.
grid on;

