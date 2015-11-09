function [ NOISY_IMG ] = gaussianNoise(IMG, variance)
    noise = sqrt(variance).*randn(size(IMG))-0.5;
    NOISY_IMG = double(IMG) + noise;
end