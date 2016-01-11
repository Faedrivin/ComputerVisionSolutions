clear, close all;
quickrun = 1; % only one image and three templates
scaling = 0.2; % scale everything down (cropping would be better...)

%% Exercise 2 - Correlation coefficient

templates = loadImages('../../images/waldo');
images = {'wheresWaldo1.jpg', 'wheresWaldo2.jpg'};

if quickrun
    images = images(1);
    templates = templates(2:4);
end

%%

for imageName = images
    image = im2double(imread(fullfile('../../images/', imageName{1, 1})));

    if scaling ~= 1
        image = imresize(image, scaling);
        for i = 1 : numel(templates)
            templates{i} = imresize(templates{i}, scaling);
        end
    end

    [rImage, cImage, ~] = size(image);

    templateCount = numel(templates);
    templateScores = zeros(templateCount, 3);
    for i = 1 : templateCount
        tic;
        res = applyColorTemplate(image, templates{i}, @corrCoeff);
        toc, disp(['Template ' num2str(i)]);
        meanRes = mean(res, 3);
        opt = max(max(meanRes));
        [r, c] = find(opt==meanRes);
        templateScores(i, :) = [r c opt];
        disp(['Finished template ' num2str(i) ' with score ' num2str(opt)]);
    end

    [templateIndices, ~, ~] = find(templateScores(:,3)==max(templateScores(:,3)));
    for tIndex = templateIndices'
        [rT, cT, ~] = size(templates{tIndex});
        r = templateScores(tIndex, 1);
        c = templateScores(tIndex, 2);

        solvedImage = image;
        solvedImage(r:r+rT, c:c+cT, 1) = solvedImage(r:r+rT, c:c+cT, 1) * 0.6;
        solvedImage(r:r+rT, c:c+cT, 2) = solvedImage(r:r+rT, c:c+cT, 2) * 0.8;
        solvedImage(r:r+rT, c:c+cT, 3) = min(solvedImage(r:r+rT, c:c+cT, 3) * 1.3, 1);

        figure;
            subplot(1, 3, 1);
                imshow(image, []);
            subplot(1, 3, 2);
                imshow(templates{tIndex}, []);
            subplot(1, 3, 3);
                imshow(solvedImage, []);
    end
end