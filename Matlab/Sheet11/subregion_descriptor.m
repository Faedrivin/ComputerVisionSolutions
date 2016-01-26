function desc = subregion_descriptor(magnitude, direction, bins)
% SUBREGION_DESCRIPTOR Compute hisogram for image gradient.
%     Based on the gradient information (magnitude and direction)
%     create a 1xBINS vector desc which represents a histogram of the given 
%     image patch.
%     The bin is determined by the gradient direction and the value of the
%     histogram bin is increased by the magnitude value.
    directions = direction(:)
    magnitudes = magnitude(:)

    binBorders = linspace(min(directions), max(directions) + eps, bins);
    desc = zeros(size(binBorders));
    for i = 1 : length(directions)
        [~, c, ~] = find(binBorders <= directions);
        desc(max(c)) = desc(max(c)) + magnitudes(i);
    end
end
