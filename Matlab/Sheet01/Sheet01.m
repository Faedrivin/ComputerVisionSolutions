%% 1a)
cameraman = imread('cameraman.tif');
figure;
    imshow(cameraman);

% 1b)
cameraman_with_border = markRectangle(cameraman, 88, 32, 148-88, 90-32);
figure;
    imshow(cameraman_with_border);

cameraman_cropped = cropRectangle(cameraman, 88, 32, 148-88, 90-32);
figure;
    imshow(cameraman_cropped);

% 1c)
figure;
current = cameraman;
for i = 1:8
    subplot(2,4,i);
        imshow(current);
    % rotate by 90 deg by transposing and then flipping the rows
    current = current';
    current = current(size(current, 1):-1:1, :);
    
    % for the 5th (thus on the fourth) mirror the columns:
    if i == 4
        current = current(:, size(current, 2):-1:1);
    end
end

%% 2a)
noisyCameraman = gaussianNoise(cameraman, 150);
figure;
    imshow([noisyCameraman(:,1:end/2) cameraman(:,end/2:end)]);
    
% 2b)
impulseCameraman = impulseNoise(cameraman, 0.005);
figure;
    imshow([impulseCameraman(:,1:end/2) cameraman(:,end/2:end)]);

% 2c) 
%have to look into this

%% 3a)
coins = imread('coins.png');
coins = double(coins)./max(max(double(coins)));

% invert
invCoins = 1-coins;
figure;
    imshow([invCoins(:,1:end/2) coins(:,end/2:end)]);

% 3b)
figure;
    subplot(2,2,1)
        title('matlab')
        histogram(coins);
        
    for subplotindex = 1:3
        subplot(2,2,subplotindex+1)
            resolution = 0:0.01*subplotindex:1;
            counts = zeros(size(resolution));
            for i = 1:(size(resolution,2)-1)
                counts(i) = sum(sum(and(coins>=resolution(i), coins < resolution(i+1))));
            end
            bar(resolution, counts, 'FaceColor', [102 170 215]/255)
            title([num2str(subplotindex) ' per bin'])
    end
% 3c)
% trivial after b

% 3d)
% also trivial

%% 4a)
clear cam;
cam = webcam;
imlast = snapshot(cam);
while 1
    imcur = snapshot(cam);
    imshow(imlast);
    imlast = imcur;
end

%% 4b)
clear cam;
cam = webcam;
imlast = snapshot(cam);
while 1
    imcur = snapshot(cam);
    imshow(imabsdiff(imlast, imcur));
    imlast = imcur;
end

%% 'smartphone' test
url = 'http://hoybakken.dyndns.org:9876/jpg/image.jpg';
ss  = imread(url);
fh = image(ss);
while(1)
    ss  = imread(url);
    set(fh,'CData',ss);
    drawnow;
end
