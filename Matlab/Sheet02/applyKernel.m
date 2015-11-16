function [ resultValue ] = applyKernel( patch, kernel )
%APPLYKERNEL Applies a (2m+1)x(2n+1) kernel to an image patch.
%   Applies a kernel according to the formula:
%   $$ g\prime(x,y) = \sum_{i\in\left[-m,m\right]} 
%                       \sum_{j\in\left[-n,n\right]}
%                         k(i+m, j+n) \cdot g(x+i, y+j) $$
%
%   This means the image patch has to have the same size as the kernel.
    % resultValue = sum(sum(patch .* kernel));
    resultValue = patch(:)' * kernel(:);
end
