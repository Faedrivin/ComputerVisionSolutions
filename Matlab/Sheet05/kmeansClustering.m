function [C, w, t, W, k] = kmeansClustering(image, K, epsilon, plot)
% KMEANSCLUSTERING returns the K mean clusters for the input image.
%   The clustering is done until no cluster moved more than epsilon.
%   The algorithm returns:
%       C: A cell array of size Kx1, each row k containing 1-D indices
%          of the pixels corresponding to cluster k.
%       w: A list of size Kx3 containing the centers.
%       t: The total number of timesteps.
%       W: A cell array of size Kxt which contains a list of t centers,
%          each of size 1x3.
%       k: A list which contains the cluster index for each pixel.
    
    % only for plotting
    if plot
        figure;
    end
    
    % (0.) 1D image access, center history
    D = reshape(image, numel(image)/3, []);
    W = cell(1);

    % 1. init step counter
    t = 1;
    
    % 2a. initialize K reference vectors w
    w = rand(K, 3);
    % 2b. within a suitable bounding box in R^d
    w = repmat(min(D), K, 1) + w .* repmat((max(D) - min(D)), K, 1);
    W{t} = w;
    
    % since matlab has no GOTO, we use breaks and negate 6. (see below)
    while 1
        % 3. initialize clusters
        C = cell(K, 1);

        % 4. find most suitable center C_k for each pixel c_i
        d = pdist2(w, D);
        [~, kStar] = min(d);
        
        for k = 1 : K
            C{k} = find(kStar==k);
            % 5. recalculate centers
            if numel(C{k}) == 0 % respawn new center if needed
                w(k,:) = min(D) + rand(1, 3) .* (max(D) - min(D));
            else
                w(k,:) = mean(D(C{k},:), 1);
            end
        end
        W{t+1} = w;
    
        if plot
            clf
            scatter3(D(:,1), D(:,2), D(:,3), 5, kStar');
            hold on;
            scatter3(w(:,1), w(:,2), w(:,3), 500, (1:K)', 'x');
            hold off;
            drawnow
        end
        
        % 6. check for changes below threshold
        if any(sqrt(sum((W{t+1} - W{t}) .^ 2, 2)) > epsilon)
            t = t + 1;
            % "goto 3"
        else % else finish
            break
        end
    end
    
    % reduce step counter to accomodate for 1-indexing
    t = t - 1;
    % output kStar
    k = kStar';
end
