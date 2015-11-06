function [ kernel ] = binomialApproximationKernel( n )
%BINOMIALAPPROXIMATIONKERNEL Calculates a filter kernel which approximates
%   a gaussian kernel via a binomial approximation.
%   The kernel size will be (2n+1)x(2n+1).
    values = abs(pascal(2*n+1,1));
    values = values(end,:);
    kernel = values' * values / sum(sum(values' * values));
end
