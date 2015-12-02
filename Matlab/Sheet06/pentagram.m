function coords = pentagram( height, center )
% PENTAGRAM calculates pentagram coordinates to be used with
%   polyimage.
%   Calculates the coordinates for a pentagram of height
%   height around the center point.
%   height has to be a scalar, center a 2x1 matrix containing an x and y
%   coordinate.
%   
%   See also polyimage.

    rotMat = @(a) [cosd(a) sind(a); -sind(a) cosd(a)];

    rot18 = rotMat(18);
    rot36 = rotMat(36);

    coords = zeros(2, 5);
    coords(:, 1) = [center(1) ; center(2) - round(height / 2)];
    coords(:, 2) = coords(:, 1) + rot18 * [0 ; round(height / cosd(18))];
    for i = 3 : 5
        prev = coords(:, i-1);
        coords(:, i) = prev + rot36 * (coords(:, i-2) - prev);
    end

end

