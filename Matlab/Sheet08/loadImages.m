function images = loadImages( dirPath )
%LOADIMAGES Loads all images in the given path into a cell array.
    lsfiles = dir(dirPath);
    lsfiles = lsfiles(3:end,:);
    images = cell(size(lsfiles, 1), 1);
    for i = 1 : size(lsfiles, 1)
        images{i} = im2double(imread(fullfile(dirPath, lsfiles(i).name)));
    end
end

