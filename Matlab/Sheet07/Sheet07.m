% start 17:20 end 17:55

dolly = im2double(imread('../../images/dolly.png'));
dollyFT = fft2(dolly);

dollyAmplitude = abs(dollyFT);
dollyPhase = angle(dollyFT);

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
dollyBack = real(ifft2(dollyAmplitude .* exp(1i * dollyPhase)));
figure; imshow(dollyBack, []);