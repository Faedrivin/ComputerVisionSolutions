%% Exercise 2)

imgs = zeros(1, 256, 256);
% triangle "pointing" rightwards
imgs(1, :, :) = polyimage([64 192 64; 64 128 192]);
% three vertical lines
imgs(2, :, [64 128 192]) = 1;
% rotated square
imgs(3, :, :) = polyimage([64 128 192 128; 128 64 128 192]);
% pentagram
imgs(4, :, :) = polyimage(pentagram(192, [128 128]));

plothough(imgs, @houghtransform);
