function similarityImage = applyTemplate( image, template, similarityFun )
%FILTERIMAGEFUNC Filters an image with the given kernel function.
%   Iterates over all pixels of the image and applies the provided filter
%   kernel.
%   The similarity function should take an image patch and a template.
    image = rgb2gray(image);
    template = rgb2gray(template);
    szImage = size(image);
    szTemplate = size(template);
    
    similarityImage = zeros(szImage);
    
    for y = 1 : max(szImage(1) - szTemplate(1), 1)
        for x = 1 : max(szImage(2) - szTemplate(2), 1)
            patch = image(y : y + szTemplate(1) - 1, ...
                          x : x + szTemplate(2) - 1);
            similarityImage(y, x) = similarityFun(patch, template);
        end
    end
end
