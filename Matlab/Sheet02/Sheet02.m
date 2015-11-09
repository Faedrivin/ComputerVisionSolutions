%% Exercise 1a-c)
% a) see applyKernel
% b) & c) see filterImage
buildingImg = im2double(imread('../../images/building.jpg'));
gaussianKernel = fspecial('gaussian', 5, 1);
binomialApproxKernel = binomialApproximationKernel(2);
figure;
    subplot(1, 3, 1);
        imshow(filterImage(buildingImg, gaussianKernel));
        title('Gaussian Blur');
    subplot(1, 3, 2);
        imshow(buildingImg);
        title('Original');
    subplot(1, 3, 3);
        imshow(filterImage(buildingImg, binomialApproxKernel));
        title('Binomial Blur');

%% Exercise 1d)
buildingImg = im2double(imread('../../images/building.jpg'));
figure;
    for i = 1 : 4
        subplot(2, 4, i);
            kernelSize = 2 * i + 1;
            kernel = fspecial('gaussian', kernelSize, 1);
            tic;
            filteredBuilding = filterImage(buildingImg, kernel);
            time = toc;
            imshow(filteredBuilding);
            title(['Non-sep. Kernel ' num2str(kernelSize) ...
                   'x' num2str(kernelSize)...
                   '; Time: ' num2str(time) ' ms']);
            
        subplot(2, 4, i + 4);
            kernelSize = 2 * i + 1;
            kernel = fspecial('gaussian', kernelSize, 1);
            tic;
            filteredBuilding = separatedFilterImage(buildingImg, kernel);
            time = toc;
            imshow(filteredBuilding);
            title(['Sep. Kernel ' num2str(kernelSize) ...
                   'x' num2str(kernelSize)...
                   '; Time: ' num2str(time) ' ms']);
    end

        
%% Exercise 2)
%% Exercise 2a)
carImg = im2double(imread('../../images/car.jpg'));

figure;
    subplot(2, 4, 1);
        imshow(filterImage(carImg, [1 0 -1]'));
        title('Simple Gradient, +V');
    subplot(2, 4, 5);
        imshow(filterImage(carImg, [-1 0 1]'));
        title('Simple Gradient, -V');
    subplot(2, 4, 2);
        imshow(filterImage(carImg, [1 0 -1]));
        title('Simple Gradient, +H');
    subplot(2, 4, 6);
        imshow(filterImage(carImg, [-1 0 1]));
        title('Simple Gradient, -H');
    subplot(2, 4, 3);
        imshow(filterImage(carImg, fspecial('sobel')));
        title('Sobel, +H');
    subplot(2, 4, 7);
        imshow(filterImage(carImg, fspecial('sobel')'));
        title('Sobel, +V');
    subplot(2, 4, 4);
        imshow(filterImage(carImg, fspecial('prewitt')));
        title('Prewitt, +H');
    subplot(2, 4, 8);
        imshow(filterImage(carImg, fspecial('laplacian')));
        title('Laplacian, +H');

%% Exercise 2b)
streetImg = im2double(imread('../../images/street.png'));

filteredStreetImg = filterImage(streetImg, fspecial('laplacian'));

zeroCrossings = zeros(size(filteredStreetImg));
for y = 1 : size(filteredStreetImg, 1) - 1
    for x = 1 : size(filteredStreetImg, 2) - 1
        zeroCrossings(y,x) = any(...
            [filteredStreetImg(y, x) * filteredStreetImg(y, x+1) < 0, ...
             filteredStreetImg(y, x) * filteredStreetImg(y+1, x) < 0]);
    end
end

zeroCrossingsTheta = zeros(size(filteredStreetImg));
zeroTheta = 15;
for y = 1 : size(filteredStreetImg, 1) - 1
    for x = 1 : size(filteredStreetImg, 2) - 1
        zeroCrossingsTheta(y,x) = any(...
            [filteredStreetImg(y, x) * filteredStreetImg(y, x+1) < -zeroTheta^2, ...
             filteredStreetImg(y, x) * filteredStreetImg(y+1, x) < -zeroTheta^2]);
    end
end
figure;
    subplot(2, 2, 1);
        imshow(streetImg);
        title('Original');
    subplot(2, 2, 2);
        imshow(filteredStreetImg);
        title('Laplacian filter');
    subplot(2, 2, 3);
        imshow(zeroCrossings);
        title('ZeroCrossings');
    subplot(2, 2, 4);
        imshow(zeroCrossingsTheta);
        title(['ZeroCrossings Theta = ' num2str(zeroTheta)]);

%% Exercise 3
noisyStreet = imnoise(im2double(imread('../../images/street.png')), 'gaussian');
saltyStreet = imnoise(im2double(imread('../../images/street.png')), 'salt & pepper');

minFunc = @(patch) min(patch(:));
maxFunc = @(patch) max(patch(:));
selectMiddle = @(array) array(ceil(end/2));
medFunc = @(patch) selectMiddle(sort(patch(:)));
snnFunc = @symmetricNearestNeighbour;

figure;
    subplot(2, 5, 1);
        imshow(noisyStreet);
        title('Gaussian');
    subplot(2, 5, 6);
        imshow(saltyStreet);
        title('Salt&Pepper');
    % a)
    subplot(2, 5, 2);
        imshow(filterImageFunc(noisyStreet, minFunc, 1, 1));
        title('Min');
    subplot(2, 5, 7);
        imshow(filterImageFunc(saltyStreet, minFunc, 1, 1));
        title('Min');
    subplot(2, 5, 3);
        imshow(filterImageFunc(noisyStreet, maxFunc, 1, 1));
        title('Max');
    subplot(2, 5, 8);
        imshow(filterImageFunc(saltyStreet, maxFunc, 1, 1));
        title('Max');
    % b)
    subplot(2, 5, 4);
        imshow(filterImageFunc(noisyStreet, medFunc, 1, 1));
        title('Median');
    subplot(2, 5, 9);
        imshow(filterImageFunc(saltyStreet, medFunc, 1, 1));
        title('Median');
    % c)
    subplot(2, 5, 5);
        imshow(filterImageFunc(noisyStreet, snnFunc, 1, 1));
        title('SNN');
    subplot(2, 5, 10);
        imshow(filterImageFunc(saltyStreet, snnFunc, 1, 1));
        title('SNN');

%% Exercise 4a)
noteImg = im2double(imread('../../images/note.png'));

erosionSimple = @(patch) all(patch(:));
dilationSimple = @(patch) any(patch(:));

mask = [1 0 0; 1 0 0; 1 0 0];
erosionMask = @(patch) all(patch(:) == mask(:));
mask = [0 0 0 0 0; 0 0 0 0 0; 0 0 0 0 1];
dilationMask = @(patch) any(patch(:) == mask(:));

figure;
    subplot(2, 3, 1);
        imshow(noteImg);
        title('Original')
    subplot(2, 3, 2);
        imshow(filterImageFunc(noteImg, erosionSimple, 1, 1));
        title('Erosion Simple')
    subplot(2, 3, 3);
        imshow(filterImageFunc(noteImg, dilationSimple, 1, 1));
        title('Dilation Simple')
    subplot(2, 3, 5);
        imshow(filterImageFunc(noteImg, erosionMask, 1, 1));
        title('Erosion Complex')
    subplot(2, 3, 6);
        imshow(filterImageFunc(noteImg, dilationMask, 1, 2));
        title('Dilation Complex')

%% Exercise 4b)
leafImg = im2double(imread('../../images/leaf.png'));

erosion = @(patch) all(patch(:));

distanceTransformLeaf = zeros(size(leafImg));
remainingLeaf = leafImg;
currentDistance = 0;
for i = 1 : max(size(leafImg))
    eroded = filterImageFunc(remainingLeaf, erosion, 1, 1);
    distanceTransformLeaf(logical(remainingLeaf - eroded)) = currentDistance;
    remainingLeaf = eroded;
    currentDistance = currentDistance + 1;
end

figure;
    subplot(2, 2, 1);
        imshow(leafImg);
        title('Original');
    subplot(2, 2, 2);
        imshow(filterImageFunc(leafImg, erosion, 1, 1));
        title('Eroded');
    subplot(2, 2, 3);
        imshow(leafImg - filterImageFunc(leafImg, erosion, 1, 1));
        title('Border');
    subplot(2, 2, 4);
        imshow(distanceTransformLeaf, [min(distanceTransformLeaf(:)) max(distanceTransformLeaf(:))])
        title('Distance Transform');

%% Exercise 4c)
shapeA = im2double(imread('../../images/leaf.png'));
shapeB = im2double(imread('../../images/leafUpsideDown.png'));
distA = bwdist(shapeA);
distB = bwdist(shapeB);

N = 8;
figure;
    for i = 0 : N
        subplot(3, 3, i+1);
            distI = (i * distB + (N - i) * distA)/N;
            imshow(distI < 0.5)
            title([num2str(i/N*100) '%']);
    end

