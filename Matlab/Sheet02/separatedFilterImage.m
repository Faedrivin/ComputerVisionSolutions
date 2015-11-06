function [ filteredImage ] = separatedFilterImage( image, kernel )
%SEPARATEDFILTERIMAGE Applies a given kernel to an image.
%   The computation is separated into horizontal and vertical directions.
    kernelM = (size(kernel, 1) - 1) / 2;
    kernelN = (size(kernel, 2) - 1) / 2;
    [U, S, V] = svd(kernel);
    kernelCol = U(:,1) * sqrt(S(1));
    kernelRow = sqrt(S(1)) * V(:,1)';
    filteredImage = zeros(size(image));
    image = image([ones(1, kernelM) 1:end ones(1, kernelM) * end], ...
                  [ones(1, kernelN) 1:end ones(1, kernelN) * end]);
    for y = 1 : size(filteredImage, 1)
        for x = 1 : size(filteredImage, 2)
            patch = image(y : y + size(kernel, 1) - 1, ...
                          x : x + size(kernel, 2) - 1);
            filteredImage(y, x) = kernelRow * patch * kernelCol;
        end
    end
end
