%% Exercise 11 a)
image = imread(fullfile('..', '..', 'images', 'templateshog', 'tmp30.png'));
[magnitude, direction] = imgradient(image);

%% Exercise 11 b)
desc = subregion_descriptor(magnitude, direction, 8);
figure('Name', 'Subregion Descriptor Template 30');
    bar(desc);

%% Exercise c-e) in function getFeatureVectors
fV = getFeatureVectors(image, 5, 4, 8);

%% Exercise 11 f)
addpath(fullfile('..', 'Sheet08')); % reuse loadImages from Sheet08
subregionSize = 5;
regionSize = 4;
bins = 8;

templates = loadImages(fullfile('..', '..', 'images', 'templateshog'));
numTemplates = size(templates, 1);
templateVectors = cell(size(templates));
for i = 1 : numTemplates
    templateVectors{i} = getFeatureVectors(templates{i}, subregionSize, regionSize, bins);
    disp(['Template ' num2str(i) ' done.'])
end
disp('Templates calculated.')

testimages = loadImages(fullfile('..', '..', 'images', 'testing'));
numImages = size(testimages, 1);
featureVectors = cell(size(testimages));
for i = 1 : numImages
    featureVectors{i} = getFeatureVectors(testimages{i}, subregionSize, regionSize, bins);
    disp(['Image ' num2str(i) ' done.'])
end
disp('Images calculated.')

%% Exercise 11 g)

% 11 h) threshold:
threshold = 0.16;

result = zeros(numImages, 2);

for imgIdx = 1 : numImages
    distances = Inf * ones(numTemplates, size(templateVectors{1}, 1));
    counts = zeros(numTemplates, 1);
    
    % calculate minimal euclidean distances per template
    for tmpIdx = 1 : numTemplates
        [distances(tmpIdx, :), ~] = pdist2(featureVectors{imgIdx}, templateVectors{tmpIdx}, 'euclidean', 'Smallest', 1);
    end
    % finally we correct NaNs to Infs to discard them
    distances(isnan(distances(:))) = Inf;

    % determine winner by finding the closest features
    [values, closest] = min(distances);
    for tmpIdx = 1 : numTemplates
        % Exercise 11 h)
        counts(tmpIdx) = sum(closest(values < threshold) == tmpIdx);
    end
    [result(imgIdx, 1), result(imgIdx, 2)] = max(counts);
end

% plot results
figure('Name', ['Threshold: ' num2str(threshold)]);
    for imgIdx = 1 : numImages
        subplot(2, numImages, imgIdx)
            imshow(testimages{imgIdx});
        subplot(2, numImages, imgIdx + numImages)
            imshow(templates{result(imgIdx, 2)});
            title(['Score: ' num2str(result(imgIdx, 1))]);
    end
