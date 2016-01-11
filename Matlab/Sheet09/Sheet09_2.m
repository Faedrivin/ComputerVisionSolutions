%% Exercise 2a)

numberPCs = 5;

% read training images
addpath(fullfile('..', 'Sheet08'));
trainingImages = loadImages(fullfile('..', '..', 'images', 'trainimg'));
N = numel(trainingImages);
if N < 1
    error('No training images found.');
end
imageDimension = size(trainingImages{1});

figure; % plot training images
    set(gcf, 'numbertitle', 'off', 'name', 'Training images')
    for i = 1 : min(20, N)
        subplot(5, 4, i);
            imshow(trainingImages{i}, []);
    end

% transform images and calculate pca
trainingData = zeros(N, numel(trainingImages{1}));
for i = 1 : N
    trainingData(i, :) = trainingImages{i}(:);
end
coeff = pca(trainingData);

%% Exercise 2b)

figure; % plot eigenfaces
    set(gcf, 'numbertitle', 'off', 'name', 'Eigenfaces')
    for i = 1 : min(20, size(coeff, 2))
        subplot(5, 4, i);
            imshow(reshape(coeff(:, i), imageDimension), []);
    end

%% Exercise 2c)

meanFace = mean(trainingData);
centeredFaces = trainingData - repmat(meanFace, N, 1);

base = [coeff(:, 1:numberPCs) zeros(size(coeff) - [0 numberPCs - 1])];
featureVectors = centeredFaces * base;

figure; % plot mean face
    set(gcf, 'numbertitle', 'off', 'name', 'Mean face')
            imshow(reshape(meanFace, imageDimension), []);

figure; % plot centered faces
    set(gcf, 'numbertitle', 'off', 'name', 'Centered faces')
    for i = 1 : min(20, size(centeredFaces, 2))
        subplot(5, 4, i);
            imshow(reshape(centeredFaces(i, :), imageDimension), []);
    end

%% Exercise 2d)

projectedTraining = (trainingData - repmat(meanFace, N, 1)) * base;
[~, I] = pdist2(featureVectors, projectedTraining, 'euclidean', 'Smallest', Inf);

figure;
    set(gcf, 'numbertitle', 'off', 'name', 'Test with training set')
    for i = 1 : 2 : 2 * N
        subplot(5, 8, i)
            imshow(trainingImages{(i + 1) / 2}, []);
            title('expected')
        subplot(5, 8, i + 1)
            imshow(trainingImages{I(1, (i + 1) / 2)}, []);
            title('matched')
    end

%% Exercise 2e)

testImages = loadImages(fullfile('..', '..', 'images', 'testimg'));
M = numel(testImages);
if M < 1
    error('No test images found.');
end
testData = zeros(M, numel(testImages{1}));
for i = 1 : M
    testData(i, :) = testImages{i}(:);
end

projectedTest = (testData - repmat(meanFace, N, 1)) * base;
[~, I] = pdist2(featureVectors, projectedTest, 'euclidean', 'Smallest', Inf);

figure;
    set(gcf, 'numbertitle', 'off', 'name', 'Classification with test set')
    for i = 1 : 2 : 2 * N
        subplot(5, 8, i)
            imshow(testImages{(i + 1) / 2}, []);
            title('testimage')
        subplot(5, 8, i + 1)
            imshow(trainingImages{I(1, (i + 1) / 2)}, []);
            title('matched')
    end
