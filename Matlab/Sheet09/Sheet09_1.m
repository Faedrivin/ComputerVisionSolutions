%% Exercise 1)
A = magic(6); 
% A = magic(8);
[Vectors, Values] = eig(A);

Results = zeros(size(Vectors));
for i = 1 : size(Vectors, 2)
    Results(:, i) = A * Vectors(:, i) / Values(i, i);
end

% A multiplied with one of its eigenvectors leads to the eigenvector scaled 
% by the corresponding eigenvalue, thus dividing it with the value yields 
% the eigenvector again.
% At least this holds for real values. (Try magic(8) for complex values).