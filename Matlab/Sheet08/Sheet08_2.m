%% Exercise 2
templates = loadImages('../../images/waldo');

%% waldo 1
wheresWaldo1 = im2double(imread('../../images/wheresWaldo1.jpg'));

res = applyTemplate(wheresWaldo1, templates{3}, @MAD);
imshow(res, []);

