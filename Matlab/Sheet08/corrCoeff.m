function C = corrCoeff( imagePatch, template )
%CORRCOEFF Calculates the correlation coefficient between a given image
%       patch and a template of the same size.
%       The image patch should only contain gray values.
    C = sum(sum(cov(imagePatch(:), template(:)))) / (std(imagePatch(:)) * std(template(:)));
end

