function image = polyimage(polygon, M, N)
% POLYIMAGE returns a black image with a white
%   polygon drawn on it.
%   polygon is a 2xP matrix where the first
%   row corresponds to x values and the second to
%   y values for poly2mask.
%   M and N are the dimensions of the resulting image. If M or N are
%   omitted, a default image of size 256x256 is created.
%
%   This function first creates a polygon mask with the supplied polygon
%   and then applies a laplacian filter, such that only the borders remain.
%     
%   See also poly2mask

    if nargin < 3
        M = 256;
        N = 256;
    end
    
    image = imfilter(poly2mask(polygon(1, :), polygon(2, :), M, N), ...
                     fspecial('laplacian'));

end