%% Exercise 1a)
% Create images with a single point.
imgs = zeros(4, 256, 256);
imgs(1, 128, 128) = 1; % image center
imgs(2, 6, 6) = 1;     % top left corner
imgs(3, 250, 250) = 1; % bottom right corner
imgs(4, 200, 100) = 1; % somwhere in the lower left quadrant

plothough(imgs);

%% Exercise 1b)
imgs = zeros(1, 256, 256);
imgs(1, [64 128 192], 128) = 1; % vertical pixels
imgs(2, 64:32:192, 128) = 1;    % more vertical pixels
imgs(3, 128, 20:20:236) = 1;    % horizontal pixels

plothough(imgs)

%% Exercise 1c)
% Images with lines

imgs = zeros(5, 256, 256);
imgs(1, 65:192, 128) = 1;             % centered vertical line
imgs(2, 65:192, 192) = 1;             % shifted vertical line
imgs(3, 128, 65:192) = 1;             % horizontal line
imgs(4, 65:192, 65:192) = eye(128);   % diagonal line (tl -> br)
imgs(5, :, :) = imgs(4, :, end:-1:1); % diagonal line (bl -> tr)

plothough(imgs);

%% Exercise 1d)
polygons = cell(3, 1);
% triangle
polygons{1} = [64  128 192; ...
               192  64 192]; 
% square
polygons{2} = [64 192 192  64; ...
               64  64 192 192];
% cross
polygons{3} = [ 64 118 118 138 138 192 192 138 138 118 118  64;...
               118 118  64  64 118 118 138 138 192 192 138 138];

imgs = zeros(size(polygons, 1), 256, 256);
for i = 1 : size(polygons, 1)
    imgs(i, :, :) = polyimage(polygons{i});
end

plothough(imgs);

%% Exercise 1e)
imgs = zeros(1, 256, 256);
% triangle "pointing" rightwards
imgs(1, :, :) = polyimage([64 192 64; 64 128 192]);
% three vertical lines
imgs(2, :, [64 128 192]) = 1;
% rotated square
imgs(3, :, :) = polyimage([64 128 192 128; 128 64 128 192]);
% pentagram
imgs(4, :, :) = polyimage(pentagram(192, [128 128]));

plothough(imgs);
