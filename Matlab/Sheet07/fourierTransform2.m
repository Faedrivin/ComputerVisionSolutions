function c = fourierTransform2( image )
%FOURIERTRANSFORM Performs a 2D fourier transformation.
%   Calculates a two-dimensional discrete version of Fourier
%   Transformation.

    rowFT = complex(zeros(size(image)));
    c = complex(zeros(size(image)));

    for row = 1 : size(image, 1)
        rowFT(row, :) = fourierTransform(image(row, :));
    end
    
    for col = 1 : size(image, 2)
        c(:, col) = fourierTransform(rowFT(:, col)')';
    end
    
end

