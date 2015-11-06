function [ filteredImage ] = filterImage( image, kernel )
%FILTERIMAGE Filters an image with the given kernel.
%   Iterates over all pixels of the image and applies the provided filter
%   kernel.
    kernelM = (size(kernel, 1) - 1) / 2;
    kernelN = (size(kernel, 2) - 1) / 2;
    filteredImage = zeros(size(image));
    image = image([ones(1, kernelM) 1:end ones(1, kernelM) * end], ...
                  [ones(1, kernelN) 1:end ones(1, kernelN) * end]);
    
    for y = 1 : size(filteredImage, 1)
        for x = 1 : size(filteredImage, 2)
            patch = image(y : y + size(kernel, 1) - 1, ...
                          x : x + size(kernel, 2) - 1);
            filteredImage(y, x) = applyKernel(patch, kernel);
        end
    end
end
