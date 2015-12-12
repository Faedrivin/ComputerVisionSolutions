%% Exercise 3a)

text = imread('../../images/text_deg.jpg');
textFFT = fft2(text);
textAmp = log(fftshift(abs(textFFT)));

figure;
    imshow(textAmp, []);

%% Exercise 3b)

[rows, cols] = find(textAmp > 11);
polycoeff = polyfit(cols, rows, 1);
% '90 +' because of image origin, should usually be '90 -'
rotationAngle = 90 + atan(polycoeff(1)) * 180 / pi;

% Exercise 3c)
textRotated = imrotate(text, rotationAngle);

figure;
    subplot(1, 3, 1);
        imshow(text, []);
        title('Original');
    subplot(1, 3, 2);
        imshow(textAmp, []);
        hold on;
        plot(min(cols):max(cols), polyval(polycoeff, min(cols):max(cols)), 'r');
        hold off;
        title('Amplitude and regression');
    subplot(1, 3, 3);
        imshow(textRotated, []);
        title('rotated');
