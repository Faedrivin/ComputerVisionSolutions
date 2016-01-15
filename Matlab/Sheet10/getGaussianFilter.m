function filter = getGaussianFilter( sz, sigma )
%GETGAUSSIANFILTER Calculates a gaussian filter.
%   This function calculates a guassian filter after the Lowe paper.
%   For even sized dimensions 0 is considered to be between the two central
%   pixels, for odd sized dimensions 0 is considered to be the central
%   pixel. That means that the values at which the filter is evaluated is
%   always integer values for odd dimensions but decimal values ending on
%   .5 for even values.
%   mu is always in the center (thus at 0), thus it is only possible to
%   provide sigma.
    
    if mod(sz(1), 2) == 1 % odd
        x = repmat(-floor((sz(1) - 1) / 2):floor(sz(1) / 2), [sz(2) 1])';
    else % even
        x = repmat((-sz(1) / 2 + 0.5):(sz(1) / 2 - 0.5), [sz(2) 1])';
    end
    if mod(sz(2), 2) == 1 % odd
        y = repmat(-floor((sz(2) - 1) / 2):floor(sz(2) / 2), [sz(1) 1]);
    else % even
        y = repmat((-sz(2) / 2 + 0.5):(sz(2) / 2 - 0.5), [sz(1) 1]);
    end
    filter = 1 / (2 * pi * sigma ^ 2) * exp(-(x .^ 2 + y .^ 2) / (2 * sigma ^ 2));

end

