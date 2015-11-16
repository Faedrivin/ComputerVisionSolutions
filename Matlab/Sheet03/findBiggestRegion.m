function imageOut = findBiggestRegion( imageIn )
%REDUCEIMAGETOBIGGESTREGION 
    labels = bwlabel(imopen(maskRGB(imageIn), strel('disk', 3, 0)));
    [N, res] = histcounts(labels);
    if size(N, 2) > 1
        sorted = sort(N);
        val = mean( res(find(N==sorted(end-1)):find(N==sorted(end-1))+1) );
    else
        val = 1;
    end
    imageOut = labels == val;
end

