function plotOctavesWithKeypoints( octaves, keypoints, original )
%PLOTOCTAVESWITHKEYPOINTS Plots the octaves and marks keypoints.
%    Also plots the image with all remaining keypoints in a separate
%    figure.
    
    Noctaves = size(octaves, 1);
    Nscales = size(octaves, 2);
    
    colors = [ones(Noctaves, 1) (0.2 : (0.8 / (Noctaves - 1)) : 1)'  zeros(Noctaves, 1)];

    kpX = cell(Noctaves, Nscales);
    kpY = cell(Noctaves, Nscales);
    for kpI = 1:numel(kpX)
        kpX{kpI} = [];
        kpY{kpI} = [];
    end
    for keypoint = keypoints
        kpX{keypoint{1}(1), keypoint{1}(2)}(end+1) = keypoint{1}(4);
        kpY{keypoint{1}(1), keypoint{1}(2)}(end+1) = keypoint{1}(3);
    end
    
    figure;
        for o = 1 : Noctaves
            for s = 1 : Nscales
                subplot(Noctaves, Nscales, Nscales * (o - 1) + s);
                    imshow(octaves{o, s}, []);
                    hold on;
                    scatter(kpX{o, s}(:), kpY{o, s}(:), '*', 'MarkerEdgeColor', colors(o, :));
                    hold off;
            end
        end

    figure;
        imshow(original, []);
        hold on;
        scale = 1;
        for o = 1 : Noctaves
            for s = 1 : Nscales
                hold on;
                scatter(kpX{o, s}(:) * scale, kpY{o, s}(:) * scale, '*', 'MarkerEdgeColor', colors(o, :));
                hold off;
            end
            scale = scale * 2;
        end
        hold off;

    disp(['Keypoints: ' num2str(length(keypoints))])
end

