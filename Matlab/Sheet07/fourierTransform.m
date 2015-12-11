function c = fourierTransform( signal )
%FOURIERTRANSFORM Performs a fourier transformation.
%   Calculates a one-dimensional discrete version of Fourier
%   Transformation.

    L = numel(signal);
    x = 1 : L;
    c = complex(zeros(1, L));
    constant = 2 * pi * 1i / L;
    for n = 0:(L-1)
        c(n+1) = sum( signal .* exp(constant * x * n) );
    end
end

