%% Exercise 2a)

func1 = @(x) sin(2 * pi * x / numel(x));
func2 = @(x) (1:numel(x)) > 40 & (1:numel(x)) < 60;
func3 = @(x) gausswin(numel(x), 1./0.1)';

x = 0:100;
figure;
    funcs = {func1 func2 func3};
    for f = 1:numel(funcs)
        func = funcs{f};
        y = func(x);

        subplot(5, 3, 0 + f)
            plot(x, y);
            title(['func' num2str(f)]);

        subplot(5, 3, 3 + f);
            plot(x, abs(fourierTransform(y)));
            title('Amplitude');
        subplot(5, 3, 6 + f);
            plot(linspace(-pi, pi, numel(x)), angle(fourierTransform(y)));
            xlim([-pi pi])
            title('Phase');

        subplot(5, 3, 9 + f);
            plot(x, abs(fft(y)));
            title('Amplitude fft');
        subplot(5, 3, 12 + f);
            plot(linspace(-pi, pi, numel(x)), angle(fft(y)));
            xlim([-pi pi])
            title('Phase fft');
        drawnow
    end

%% Exercise 2b)

dolly = im2double(imread('../../images/dolly.png'));
dollyFFT = fft2(dolly);
dollyOwnFFT = fourierTransform2(dolly);

figure;
    subplot(2, 4, 1);
        imshow(dolly, []);
        title('Original (this row: own)');

    subplot(2, 4, 2);
        imshow(log(abs(dollyOwnFFT)), []);
        title('log amplitude');

    subplot(2, 4, 3);
        imshow(log(fftshift(abs(dollyOwnFFT))), []);
        title('log shift amplitude');

    subplot(2, 4, 4);
        imshow(angle(dollyOwnFFT), []);
        title('Phase');

    subplot(2, 4, 5);
        imshow(dolly, []);
        title('Original (this row: fft2)');

    subplot(2, 4, 6);
        imshow(log(abs(dollyFFT)), []);
        title('log amplitude');

    subplot(2, 4, 7);
        imshow(log(fftshift(abs(dollyFFT))), []);
        title('log shift amplitude');

    subplot(2, 4, 8);
        imshow(angle(dollyFFT), []);
        title('Phase');
