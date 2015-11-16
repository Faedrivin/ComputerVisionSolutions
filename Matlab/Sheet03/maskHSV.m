function imageOut = maskHSV( imageIn )
%MASKHSV 
    imageIn = rgb2hsv(imageIn);
    between = @(x, low, high) and(low <= x, x <= high);
    imageOut = and(and(between(mod(imageIn(:,:,1) + 0.2,1), 0, 0.4), ...
                       imageIn(:,:,2) > 0.6), ...
                   imageIn(:,:,3) > 0.5);
end
