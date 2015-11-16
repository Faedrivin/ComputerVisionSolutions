function imageOut = markObject( imageIn )
%MARKOBJECT
    %mask = maskRGB(imageIn);
    mask = findBiggestRegion(imageIn);
    [r, c] = find(mask);
    imageOut = imageIn;
    
    imageOut(min(min(r)):max(max(r)), [min(min(c)) max(max(c))], :) = 255;
    imageOut([min(min(r)) max(max(r))], min(min(c)):max(max(c)), :) = 255;

end

