%% Exercise 1a)
templates = loadImages('../../images/templates');

%% Exercise 1b)
captchas = loadImages('../../images/captchas');

demoCaptchas = 1;
demoTemplates = round(numel(templates) * 0.2);
for i = 1 : demoCaptchas
    figure;
    for j = 1 : demoTemplates
        subplot(3, demoTemplates, j);
            imshow(captchas{i}, []);
            title(char(64 + j));
        subplot(3, demoTemplates, j + demoTemplates);
            imshow(applyTemplate(captchas{i}, templates{j}, @MAD), []);
            title('MAD');
        subplot(3, demoTemplates, j + 2 * demoTemplates);
            imshow(applyTemplate(captchas{i}, templates{j}, @corrCoeff), []);
            title('corr');
    end
end

%% Exercise 1c)
% structure used: specific size
resizedTemplates = resizeImages(templates, [10 8] + 2);

%% Exercise 1d)
borderOffset = [7 10 7 10];
letterOffset = [0 -1];

numberCaptchas = numel(captchas);
figure;
    for i = 1 : numberCaptchas
        subplot(1, numberCaptchas, i);
            imshow(captchas{i}, []);
            title(solveCaptcha(captchas{i}, resizedTemplates, @MAD, @lt, borderOffset, letterOffset));
    end
    set(gcf, 'numbertitle', 'off', 'name', 'Mean Absolute Difference')

figure;
    for i = 1 : numberCaptchas
        subplot(1, numberCaptchas, i);
            imshow(captchas{i}, []);
            title(solveCaptcha(captchas{i}, resizedTemplates, @corrCoeff, @gt, borderOffset, letterOffset));
    end
    set(gcf, 'numbertitle', 'off', 'name', 'Correlation Coefficient')
