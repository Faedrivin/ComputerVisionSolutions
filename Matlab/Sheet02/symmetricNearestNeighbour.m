function [ filteredPatch ] = symmetricNearestNeighbour( imagePatch )
%SYMMETRICNEARESTNEIGHBOUR Mean filter which only averages the
%   best four matches around the center point P. The kernel size is always
%   3x3.
    P = imagePatch(2, 2);
    blend = @(A, P, B) A * P + B * (1 - P);
    pairs = [[1, 1], [3, 3]; [1, 2], [3, 2]; [1, 3], [3, 1]; [2, 1], [2, 3]];
    
    filteredPatch = 0;
    for i = pairs'
        filteredPatch = filteredPatch + blend(imagePatch(i(1), i(2)),...
            abs(P - imagePatch(i(1), i(2))) < abs(P - imagePatch(i(3), i(4))),...
            imagePatch(i(3), i(4)));
    end
    filteredPatch = filteredPatch / 4;
end
