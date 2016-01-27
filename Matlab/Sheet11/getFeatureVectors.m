function featureVectors = getFeatureVectors(image, subregionSize, regionSize, bins)
% GETFEATUREVECTORS calculates the histogram of oriented gradients' feature
%     vectors for the given image. 
%     First calculates subregion descriptors (with bins many bins) on 
%     patches with subregionSize x subregionSize, then uses these in an 
%     overlapping fashion to calculate the regionSize x regionSize feature 
%     vectors.
%     The resulting vectors are normalized to a sum of 1. However, some
%     might have length 0 and will then result in NaN vectors. Take this
%     into account when comparing them.
%
%     Also note that this function takes the remainders at the right and
%     bottom edges as "smaller" regions.

    %% Exercise 11 c)
    patchFeatures = zeros(ceil([size(image) ./ subregionSize, bins]));
    for x = 1 : subregionSize : size(image, 2)
        for y = 1 : subregionSize : size(image, 1)
            patch = image(y : min(end, y + subregionSize), ...
                          x : min(end, x + subregionSize));
            [magnitude, direction] = imgradient(patch);
            patchFeatures( (y - 1) / 5 + 1, (x - 1) / 5 + 1, :) = ...
                    subregion_descriptor(magnitude, direction, bins);
        end
    end

    %% Exercise 11 d)
    featureVectors = zeros([size(patchFeatures, 1) - 1, ...
                            size(patchFeatures, 2) - 1, ...
                            regionSize * regionSize * bins]);
    for fX = 1 : size(featureVectors, 2)
        for fY = 1 : size(featureVectors, 1)
            bin = 1 : bins;
            for subY = fY : min(fY + regionSize - 1, size(patchFeatures, 1))
                for subX = fX : min(fX + regionSize - 1, size(patchFeatures, 2))
                    featureVectors(fY, fX, bin) = patchFeatures(subY, subX, :);
                    bin = bin + bins;
                end
            end
        end
    end
    
    % for convenience we also reshape the feature vectors
    featureVectors = reshape(featureVectors, [], regionSize * regionSize * bins);
    
    %% Exercise 11 e)
    % careful: can cause Div#0, thus lots of NaN vectors
    for i = 1 : size(featureVectors, 1)
        featureVectors(i, :) = featureVectors(i, :) / sum(featureVectors(i, :));
    end
end