function filtered = applyFilterFFT(image, filter)
%APPLYFILTERFFT This function filters an image by transforming the image
%               and the filter into the frequency domain and multiplying
%               them.
%   The function first pads image and filter with 0s and removes the
%   padding at the end. However depending on the filter used this will
%   lead to heavy artifacts close to the boundaries.

    % zero padding
    paddedMask = padarray(ones(size(image)), floor((size(filter) - 1) / 2));
    paddedMask = padarray(paddedMask, mod(size(filter) + 1, 2), 0, 'post');

    paddedImage = paddedMask;
    paddedImage(paddedMask==1) = image(:);

    paddedFilter = padarray(filter, floor((size(image) - 1) / 2));
    paddedFilter = padarray(paddedFilter, mod(size(image) + 1, 2), 0, 'post');

    % filtering
    filtered = real(ifft2(fft2(paddedFilter) .* fft2(paddedImage)));
    
    % correction because MATLAB...
    filtered = fftshift(filtered);
    
    % crop padding
    filtered = reshape(filtered(paddedMask==1), size(image));
end