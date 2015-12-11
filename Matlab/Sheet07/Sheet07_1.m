dolly = im2double(imread('../../images/dolly.png'));
dollyFFT = fft2(dolly);

dollyAmplitude = abs(dollyFFT);
dollyPhase = angle(dollyFFT);

%% Exercise 1a)
figure;
    subplot(1, 3, 1);
        histogram(dollyAmplitude);
        title('Amplitude');

    subplot(1, 3, 2);
        histogram(log(dollyAmplitude));
        title('log(Amplitude)');

    subplot(1, 3, 3);
        histogram(dollyPhase);
        title('Phase');

%% Exercise 1b)
figure;
    subplot(2, 2, 1);
        imshow(dollyAmplitude, []);
        title('Amplitude');

    subplot(2, 2, 2);
        imshow(log(dollyAmplitude), []);
        title('log(Amplitude)');

    subplot(2, 2, 3);
        imshow(log(fftshift(dollyAmplitude)), []);
        title('log(shift(Amplitude))');

    subplot(2, 2, 4);
        imshow(dollyPhase, []);
        title('Phase');

%% Exercise 1c)
dollyBackFFT = real(fft2(dollyAmplitude .* exp(1i * dollyPhase)));
dollyBackFFTcorrected = real(fft2(dollyAmplitude .* exp(-1i * dollyPhase)));
dollyBackIFFT = real(ifft2(dollyAmplitude .* exp(1i * dollyPhase)));

figure; 
    subplot(1, 3, 1);
        imshow(dollyBackFFT, []);
        title('Reverted using FFT');

    subplot(1, 3, 2);
        imshow(dollyBackFFTcorrected, []);
        title('Reverted using FFT + correction');

    subplot(1, 3, 3);
        imshow(dollyBackIFFT, []);
        title('Reverted using IFFT');

%% Exercise 1d)

dollyPhase0 = real(fft2(dollyAmplitude));
dollyPhasePiBy2 = real(ifft2(dollyAmplitude * exp(-1i * pi/2)));
dollyPhasePi = real(fft2(dollyAmplitude * exp(-1i * pi)));
dollyPhaseRand = real(fft2(dollyAmplitude .* exp(-1i * (rand(size(dollyAmplitude)) * 2 * pi - pi))));
dollyPhaseNoise = real(fft2(dollyAmplitude .* exp(-1i * dollyPhase .* (rand(size(dollyPhase)) + 0.5))));

figure;
    subplot(2, 3, 1);
        imshow(dolly, []);
        title('Original');

    subplot(2, 3, 2);
        imshow(dollyPhase0, []);
        title('Phase = 0');

    subplot(2, 3, 3);
        imshow(dollyPhasePiBy2, []);
        title('Phase = \pi / 2');

    subplot(2, 3, 4);
        imshow(dollyPhasePi, []);
        title('Phase = \pi');

    subplot(2, 3, 5);
        imshow(dollyPhaseRand, []);
        title('Random phase');

    subplot(2, 3, 6);
        imshow(dollyPhaseNoise, []);
        title('Noisy phase');

%% Exercise 1e)

dollyAmplitude0 = real(fft2(0));
dollyAmplitude100 = real(fft2(100 * exp(-1i * dollyPhase)));
dollyAmplitudeGauss = real(fft2(normpdf((1:size(dollyPhase, 1))' * (1:size(dollyPhase, 2)), mean(size(dollyPhase))/2, mean(size(dollyPhase))/4) .* exp(-1i * dollyPhase)));
dollyAmplitudeRand = real(fft2((rand(size(dollyPhase)) * 1000) .* exp(-1i * dollyPhase)));
dollyAmplitudeNoise = real(fft2((dollyAmplitude .* (rand(size(dollyAmplitude)) + 0.5)) .* exp(-1i * dollyPhase)));

figure;
    subplot(2, 3, 1);
        imshow(dolly, []);
        title('Original');

    subplot(2, 3, 2);
        imshow(dollyAmplitude0, []);
        title('Amplitude = 0');

    subplot(2, 3, 3);
        imshow(dollyAmplitude100, []);
        title('Amplitude = 100');

    subplot(2, 3, 4);
        imshow(dollyAmplitudeGauss, []);
        title('Gaussian amplitude');

    subplot(2, 3, 5);
        imshow(dollyAmplitudeRand, []);
        title('Random amplitude');

    subplot(2, 3, 6);
        imshow(dollyAmplitudeNoise, []);
        title('Noisy amplitude');
