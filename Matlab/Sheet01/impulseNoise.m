function [ NOISY_IMG ] = impulseNoise(IMG, percentage)
    noise = rand(size(IMG));
    noiseMask = noise > percentage;
    noise(noise<percentage/2) = 255;
    noise(noise~=255) = 0;
    NOISY_IMG = IMG .* uint8(noiseMask) + uint8(noise);
end