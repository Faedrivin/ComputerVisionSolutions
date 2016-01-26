%% Exercise 11 a)
image = imread('');
[magnitude, direction] = imgradient(image);

%% Exercise 11 b)
bins = 8;
% desc = subregion_descriptor(magnitude, direction, bins);

%% Exercise 11 c)
subregionSize = 5;
patchFeatures = zeros([size(image) ./ subregionSize, bins]);
for x = 1 : subregionSize : size(image, 2)
    for y = 1 : subregionSize : size(image, 1)
        patch = image(y : min(end, y + subregionSize), ...
                      x : min(end, x + subregionSize));
        [magnitude, direction] = imgradient(patch);
        patchFeatures( (y - 1) / 5, (x - 1) / 5, :) = ...
                subregion_descriptor(magnitude, direction, bins);
    end
end

%% Exercise 11 d)
regionSize = 4;
featureVectors = zeros([size(patchFeatures, 1) / regionSize, ...
                        size(patchFeatures, 2) / regionSize, ...
                        regionSize * regionSize * bins])
for fX = 1 : size(featureVectors, 2) - regionSize + 1
    for fY = 1 : size(featureVectors, 1) - regionSize + 1
        bin = 1 : bins;
        for subY = fY : fY + regionSize
            for subX = fX : fX + regionSize
                featureVectors(fY, fX, bin) = patchFeatures(subY, subX, :);
                bin = bin + bins;
            end
        end
    end
end

%% Exercise 11 e)
for fX = 1 : size(featureVectors, 2)
    for fY = 1 : size(featureVectors, 1)
        featureVectors(fX, fY, :) = featureVectors(fX, fY, :) ./ sum(featureVectors(fX, fY, :))
    end
end

