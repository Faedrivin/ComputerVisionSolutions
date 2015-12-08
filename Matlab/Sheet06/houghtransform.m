function [ H, theta, rho ] = houghtransform( BW )
% HOUGHTRANSFORM a simple hough transform.
%   Calculates a simple hough transformation of the given black and white
%   image. 
%   Returns H, the resulting hough space, theta, the theta values, and rho,
%   the radii.
%
%   See also hough.
    
    %% 1.
    % angles (not 0...pi as requested to compare with built-in)
    theta = linspace(0, pi);
    % possible distances
    rhoshift = ceil(pdist([0 0; size(BW)]));
    rho = -rhoshift : rhoshift;
    % accumulator space, initialized to 0
    H = zeros(numel(rho), numel(theta));
    
    %% 2.
    % edge detection
    M = imfilter(BW, fspecial('laplacian'));
    
    % fill accumulator space
    for y = 1 : size(M, 1)
        for x = 1 : size(M, 2)
            % only if pixel is an edge
            if M(y, x)
                for idx = 1 : numel(theta)
                    r = round(x * cos(theta(idx)) + y * sin(theta(idx)));
                    H(rhoshift + r, idx) = H(rhoshift + r, idx) + 1;
                end
            end
        end
    end

end

