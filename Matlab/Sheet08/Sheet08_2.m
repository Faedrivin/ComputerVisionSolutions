quickrun = 1;

%% Exercise 2
templates = loadImages('../../images/waldo');

%% MAD
images = {'wheresWaldo1.jpg', 'wheresWaldo2.jpg'};
if quickrun
    images = images{1};
    templates = templates{2:4};
end

for imageName = images
    image = im2double(imread(fullfile('../../images/', imageName{1, 1})));

    if quickrun
        image = imresize(image, 0.2);
    end

    [rImage, cImage, ~] = size(image);

    templateScores = zeros(numel(templates), 3);
    results = zeros(numel(templates), rImage, cImage)
    parfor i = 1:numel(templates)
        disp(['Calculating template ' num2str(i)]);
        tic
        res = applyColorTemplate(image, templates{i}, @MAD);
        toc
        meanRes = mean(res);
        meanRes(meanRes==0) = 1;
        templateScores(i, :) = find(min(min(meanRes))==meanRes);
        results(i, :, :) = meanRes;
    end

    [r, ~, ~] = find(templateScores(:,3)==min(templateScores(:,3)))

    solvedImage = image;
    [rT, cT, ~] = size(templates{r});
    solvedImage(r:r+rT, c:c+cT, 1) = solvedImage(r:r+rT, c:c+cT, 1) * 0.6;
    solvedImage(r:r+rT, c:c+cT, 2) = solvedImage(r:r+rT, c:c+cT, 2) * 0.8;
    solvedImage(r:r+rT, c:c+cT, 3) = min(solvedImage(r:r+rT, c:c+cT, 3) * 1.3, 1);

    figure;
        for i = 1:numel(templates)
            subplot(2, numel(templates), i);
                imshow(templates{i}, []);
            subplot(2, numel(templates), i + numel(templates));
                imshow(results(i, :, :), []);
        end

    figure;
        subplot(1, 3, 1);
            imshow(image, []);
        subplot(1, 3, 2);
            imshow(template{r}, []);
        subplot(1, 3, 3);
            imshow(solvedImage, []);
end
