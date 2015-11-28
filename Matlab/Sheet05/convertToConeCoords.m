function coords = convertToConeCoords(hsvValues)
% CONVERTTOCONECOORDS calculates the coordinate for a
%   hsv value on a cone.
%   The input must be of size Mx3, as will the output.
    h = hsvValues(:,1) * 2 * pi;
    s = hsvValues(:,2);
    v = hsvValues(:,3);
    coords = [s .* sin(h) .* v, s .* cos(h) .* v, v];
end