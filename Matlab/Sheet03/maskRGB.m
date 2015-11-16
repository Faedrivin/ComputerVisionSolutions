function imageOut = maskRGB( imageIn )
%MASKRGB
    imageOut = and(and(imageIn(:,:,1) > 120, imageIn(:,:,2) < 50), imageIn(:,:,3) < 50);
end

