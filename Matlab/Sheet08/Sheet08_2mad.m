clear, close all;
quickrun = 0; % only one image and three templates
scaling = 1; % scale everything down


%% Exercise 2 - MAD

templates = loadImages('../../images/waldo');
figure;
    for i = 1 : numel(templates)
        subplot(2, ceil(numel(templates)/2), i);
            imshow(templates{i}, []);
    end
    drawnow

images = {'wheresWaldo1.jpg', 'wheresWaldo2.jpg'};


if quickrun
    images = images(1);
    templates = templates(2:4);
end

%% 

for k = 1:numel(images)
    imageName = images{k};
    disp(imageName);
    image = im2double(imread(fullfile('../../images/', imageName)));
    figure;
        imshow(image, []);
        title('image');
    if scaling ~= 1
        image = imresize(image, scaling);
        for i = 1 : numel(templates)
            templates{i} = imresize(templates{i}, scaling);
        end
        figure;
            imshow(image, []);
            title('scaled');
    end
    drawnow

    [rImage, cImage, ~] = size(image);

    templateCount = numel(templates);
    templateScores = zeros(templateCount, 3);
    parfor i = 1 : templateCount
        disp(['Starting template ' num2str(i)]), tic;
        res = applyColorTemplate(image, templates{i}, @MAD);
        toc, disp(['Template ' num2str(i)]);
        meanRes = mean(res, 3);
        meanRes(meanRes==0) = 1;
        opt = min(min(meanRes));
        [r, c] = find(opt==meanRes);
        templateScores(i, :) = [r c opt];
        disp(['Finished template ' num2str(i) ' with score ' num2str(opt)]);
    end

    [templateIndices, ~, ~] = find(templateScores(:,3)==min(templateScores(:,3)));
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
        drawnow;
    end
end