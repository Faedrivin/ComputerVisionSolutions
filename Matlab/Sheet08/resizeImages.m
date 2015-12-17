function resized = resizeImages( images, sz )
%RESIZEIMAGES Resizes a number of images in a cell array to the 
%       specified size sz.
    resized = cell(size(images));
    for i = 1 : numel(images)
        resized{i} = imresize(images{i}, sz);
    end
end