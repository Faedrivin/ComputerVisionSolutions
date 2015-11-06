function [ filteredImage ] = filterImageFunc( image, kernelFunc, kernelM, kernelN )
%FILTERIMAGEFUNC Filters an image with the given kernel function.
%   Iterates over all pixels of the image and applies the provided filter
%   kernel.
    filteredImage = zeros(size(image));
    image = image([ones(1, kernelM) 1:end ones(1, kernelM) * end], ...
                  [ones(1, kernelN) 1:end ones(1, kernelN) * end]);
    
    for y = 1 : size(filteredImage, 1)
        for x = 1 : size(filteredImage, 2)
            patch = image(y : y + kernelM * 2, ...
                          x : x + kernelN * 2);
            filteredImage(y, x) = kernelFunc(patch);
        end
    end
end
