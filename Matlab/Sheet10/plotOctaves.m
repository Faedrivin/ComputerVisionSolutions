function plotOctaves( octaves )
%PLOTOCTAVES Plots the octaves provided.

    Noctaves = size(octaves, 1);
    Nscales = size(octaves, 2);

    figure;
        for o = 1 : Noctaves
            for s = 1 : Nscales
                subplot(Noctaves, Nscales, Nscales * (o - 1) + s);
                    imshow(octaves{o, s}, []);
            end
        end

end

