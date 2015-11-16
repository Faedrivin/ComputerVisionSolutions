function imageOut = trackObject( imageIn )
%TRACKOBJECT 
    persistent trajectory;
    
    %mask = maskRGB(imageIn);
    mask = findBiggestRegion(imageIn);
    imageOut = imageIn;
    if any(any(mask))
        [r, c] = find(mask);
        y = round((min(min(r))+max(max(r)))/2);
        x = round((min(min(c))+max(max(c)))/2);
        imageOut(max(y-4, 1):min(y+4, size(imageOut, 1)), ...
                 max(x-4, 1):min(x+4, size(imageOut, 2)), ...
                 :) = 0;
        trajectory(end+1, 1:2) = [y x];
        disp([y x])
    end
    if size(trajectory, 1) > 1
        for coords = trajectory'
            imageOut(coords(1), coords(2), :) = reshape([0 255 255], 1, 1, 3);
        end
    end
end

