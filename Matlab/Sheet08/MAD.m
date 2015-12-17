function mad = MAD( imagePatch, template )
%MAD Calculates the mean absolute difference between the input image patch
%       and the tempalte.
%   The image patch should only contain gray values.
    mad = sum(abs(imagePatch(:) - template(:))) / numel(template);
end

