function plotOctavesWithKeypoints( octaves, keypoints )
%PLOTOCTAVESWITHKEYPOINTS Plots the octaves and marks keypoints.
%    Also plots the image with all remaining keypoints in a separate
%    figure.

    Noctaves = size(octaves, 1);
    Nscales = size(octaves, 2);

    figure;
        for o = 1 : Noctaves
            for s = 1 : Nscales
                subplot(Noctaves, Nscales, Nscales * (o - 1) + s);
                    imshow(octaves{o, s}, []);
                    hold on;
                    for keypoint = keypoints
                        if keypoint{1}(1) == o && keypoint{1}(2) == s
                            % plot keypoints TODO
                            
                        end
                    end
                    hold off;
            end
        end
        
end

