function desc = subregion_descriptor(magnitude, direction, bins)
% SUBREGION_DESCRIPTOR Compute hisogram for image gradient.
%     Based on the gradient information (magnitude and direction)
%     create a 1xBINS vector desc which represents a histogram of the given 
%     image patch.
%     The bin is determined by the gradient direction and the value of the
%     histogram bin is increased by the magnitude value.
    magnitudes = magnitude(:);

    binBorders = linspace(-181, 180, bins + 1);
    desc = zeros(1, bins);
    for i = 1 : bins
        desc(i) = desc(i) ...
                + sum( magnitudes(and(binBorders(i) < direction(:), ...
                                      binBorders(i + 1) >= direction(:))));
    end
end
