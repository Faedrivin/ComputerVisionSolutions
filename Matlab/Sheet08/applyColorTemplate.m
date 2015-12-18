function similarityImage = applyColorTemplate( image, template, similarityFun )
%APPLYTEMPLATE Apples a template to an image with a given similarity
%   function.
%   The similarity function should take an image patch and a template.
    [rImage, cImage, ~] = size(image);
    [rTemplate, cTemplate, ~] = size(template);
    
    similarityImage = zeros([rImage, cImage, 3]);
    
    yLim = max(rImage - rTemplate, 1);
    xLim = max(cImage - cTemplate, 1);
    parfor y = 1 : yLim
        for x = 1 : xLim
            patch = image(y : y + rTemplate - 1, ...
                          x : x + cTemplate - 1, :); %#ok<PFBNS>
            similarityImage(y, x, :) = [feval(similarityFun, patch(:,:,1), template(:,:,1)), ... 
                                        feval(similarityFun, patch(:,:,2), template(:,:,2)), ...
                                        feval(similarityFun, patch(:,:,3), template(:,:,3))]; %#ok<PFBNS>
        end
    end
end
