%% Exercise 1
clear vars;
close all;

par = im2double(imread('parrot.jpg'));
par = imresize(par,0.2);
colors = reshape(par,[],3);

figure
subplot(1,3,1)
imshow(par)
title('CUTE!')

subplot(1,3,2)
scatter3(colors(:,1),colors(:,2),colors(:,3),1,colors);
title('Parrot in RGB')

colorsHsv = reshape(rgb2hsv(par),[],3);

h = colorsHsv(:,1);
h = h*360; % calculate in degrees
s = colorsHsv(:,2);
v = colorsHsv(:,3);


subplot(1,3,3)
scatter3(sind(h).*s.*v+0.5,cosd(h).*s.*v+0.5,v,1,colors);
title('Parrot in HSV')

