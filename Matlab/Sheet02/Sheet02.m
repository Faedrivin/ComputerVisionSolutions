%% Exercise 1a-c)
% a) see applyKernel
% b) & c) see filterImage
buildingImg = double(imread('../../images/building.jpg'));
gaussianKernel = fspecial('gaussian', 5, 1);
binomialApproxKernel = binomialApproximationKernel(2);
figure;
    subplot(1, 3, 1);
        imshow(filterImage(buildingImg, gaussianKernel), [0 255]);
        title('Gaussian Blur');
    subplot(1, 3, 2);
        imshow(buildingImg, [0 255]);
        title('Original');
    subplot(1, 3, 3);
        imshow(filterImage(buildingImg, binomialApproxKernel), [0 255]);
        title('Binomial Blur');

%% Exercise 1d)
buildingImg = double(imread('../../images/building.jpg'));
figure;
    for i = 1 : 4
        subplot(2, 4, i);
            kernelSize = 2 * i + 1;
            kernel = fspecial('gaussian', kernelSize, 1);
            tic;
            filteredBuilding = filterImage(buildingImg, kernel);
            time = toc;
            imshow(filteredBuilding, [0 255]);
            title(['Non-sep. Kernel ' num2str(kernelSize) ...
                   'x' num2str(kernelSize)...
                   '; Time: ' num2str(time) ' ms']);
            
        subplot(2, 4, i + 4);
            kernelSize = 2 * i + 1;
            kernel = fspecial('gaussian', kernelSize, 1);
            tic;
            filteredBuilding = separatedFilterImage(buildingImg, kernel);
            time = toc;
            imshow(filteredBuilding, [0 255]);
            title(['Sep. Kernel ' num2str(kernelSize) ...
                   'x' num2str(kernelSize)...
                   '; Time: ' num2str(time) ' ms']);
    end

        
%% Exercise 2)
%% Exercise 2a)
carImg = double(imread('../../images/car.jpg'));

figure;
    subplot(2, 4, 1);
        imshow(filterImage(carImg, [1 0 -1]'), [0 255]);
        title('Simple Gradient, +V');
    subplot(2, 4, 5);
        imshow(filterImage(carImg, [-1 0 1]'), [0 255]);
        title('Simple Gradient, -V');
    subplot(2, 4, 2);
        imshow(filterImage(carImg, [1 0 -1]), [0 255]);
        title('Simple Gradient, +H');
    subplot(2, 4, 6);
        imshow(filterImage(carImg, [-1 0 1]), [0 255]);
        title('Simple Gradient, -H');
    subplot(2, 4, 3);
        imshow(filterImage(carImg, fspecial('sobel')), [0 255]);
        title('Sobel, +H');
    subplot(2, 4, 7);
        imshow(filterImage(carImg, fspecial('sobel')'), [0 255]);
        title('Sobel, +V');
    subplot(2, 4, 4);
        imshow(filterImage(carImg, fspecial('prewitt')), [0 255]);
        title('Prewitt, +H');
    subplot(2, 4, 8);
        imshow(filterImage(carImg, fspecial('laplacian')), [0 255]);
        title('Laplacian, +H');

%% Exercise 2b)
streetImg = double(imread('../../images/street.png'));

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
        imshow(streetImg, [0 255]);
        title('Original');
    subplot(2, 2, 2);
        imshow(filteredStreetImg, [0 255]);
        title('Laplacian filter');
    subplot(2, 2, 3);
        imshow(zeroCrossings, [0 1]);
        title('ZeroCrossings');
    subplot(2, 2, 4);
        imshow(zeroCrossingsTheta, [0 1]);
        title(['ZeroCrossings Theta = ' num2str(zeroTheta)]);

%% Exercise 3
noisyStreet = double(imnoise(imread('../../images/street.png'), 'gaussian'));
saltyStreet = double(imnoise(imread('../../images/street.png'), 'salt & pepper'));

minFunc = @(patch) min(min(patch));
maxFunc = @(patch) max(max(patch));
selectMiddle = @(array) array(ceil(end/2));
medFunc = @(patch) selectMiddle(sort(patch(:)));
snnFunc = @symmetricNearestNeighbour;

figure;
    subplot(2, 5, 1);
        imshow(noisyStreet, [0 255]);
        title('Gaussian');
    subplot(2, 5, 6);
        imshow(saltyStreet, [0 255]);
        title('Salt&Pepper');
    % a)
    subplot(2, 5, 2);
        imshow(filterImageFunc(noisyStreet, minFunc, 1, 1), [0 255]);
        title('Min');
    subplot(2, 5, 7);
        imshow(filterImageFunc(saltyStreet, minFunc, 1, 1), [0 255]);
        title('Min');
    subplot(2, 5, 3);
        imshow(filterImageFunc(noisyStreet, maxFunc, 1, 1), [0 255]);
        title('Max');
    subplot(2, 5, 8);
        imshow(filterImageFunc(saltyStreet, maxFunc, 1, 1), [0 255]);
        title('Max');
    % b)
    subplot(2, 5, 4);
        imshow(filterImageFunc(noisyStreet, medFunc, 1, 1), [0 255]);
        title('Median');
    subplot(2, 5, 9);
        imshow(filterImageFunc(saltyStreet, medFunc, 1, 1), [0 255]);
        title('Median');
    % c)
    subplot(2, 5, 5);
        imshow(filterImageFunc(noisyStreet, snnFunc, 1, 1), [0 255]);
        title('SNN');
    subplot(2, 5, 10);
        imshow(filterImageFunc(saltyStreet, snnFunc, 1, 1), [0 255]);
        title('SNN');

%% Exercise 4a)
noteImg = double(imread('../../images/note.png'))/255;

erosionSimple = @(patch) all(all(patch));
dilationSimple = @(patch) any(any(patch));

mask = [1 0 0; 1 0 0; 1 0 0];
erosionMask = @(patch) all(all(patch == mask));
mask = [1 0 0 0 0; 0 0 0 0 0; 0 0 0 0 1];
dilationMask = @(patch) any(any((patch == mask) == mask));

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
leafImg = double(imread('../../images/leaf.png'))/255;

erosion = @(patch) all(all(patch));

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
        imshow(distanceTransformLeaf, [min(min(distanceTransformLeaf)) max(max(distanceTransformLeaf))])
        title('Distance Transform');

%% Exercise 4c)
shapeA = double(imread('../../images/leaf.png'))/255;
shapeB = double(imread('../../images/leafUpsideDown.png'))/255;
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

