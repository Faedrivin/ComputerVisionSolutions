lighthouse = rgb2gray(im2double(imread(fullfile('..','..','images','lighthouse.png'))));

%% Exercise a) Gaussian pyramid
Noctaves = 4;
Nscales = 5;
sigma = sqrt(2) .^ (0:(Nscales - 1)) * 0.5;
kernelsize = ceil(4 * sigma);

octaves = cell(Noctaves, Nscales);

for o = 1 : Noctaves
    if o == 1
        image = lighthouse;
    else
        image = octaves{o - 1, 3}(1:2:end, 1:2:end);
    end
    for s = 1 : Nscales
        filter = getGaussianFilter([kernelsize(s) kernelsize(s)], sigma(s));
        octaves{o, s} = applyFilterFFT(image, filter);
    end
end

plotOctaves(octaves);

%% Exercise b) DoG images
for o = 1 : Noctaves
    for s = Nscales : -1 : 2
        octaves{o, s} = octaves{o, s - 1} - octaves{o, s};
    end
end

plotOctaves(octaves);

%% Exercise c) Extrema in DoG images
keypoints = cell(1);
count = 0;
for o = 1 : Noctaves
    for s = 3 : Nscales - 1
        for y = 2 : size(octaves{o, s}, 1) - 1
            for x = 2 : size(octaves{o, s}, 2) - 1
                yInd = y - 1:y + 1;
                xInd = x - 1:x + 1;
                Ind = sub2ind(size(octaves{o, s-1}), [yInd' yInd' yInd'], [xInd; xInd; xInd]);
                Ind = Ind(:)';
                pix = [octaves{o, s-1}(Ind) octaves{o, s}(Ind) octaves{o, s+1}(Ind)];
                [~, c, ~] = find(pix == min(pix));
                if c ~= 14
                    [~, c, ~] = find(pix == max(pix));
                end
                if c == 14
                    count = count + 1;
                    keypoints{count} = [o, s, y, x, pix(c)];
                end
            end
        end
    end
end

plotOctavesWithKeypoints(octaves, keypoints, lighthouse);

%% Exercise d) Hessian matrix as Harris Corner detection
r = 10;
i = 1;
while i <= length(keypoints)
    o = keypoints{i}(1);
    s = keypoints{i}(2);
    y = keypoints{i}(3);
    x = keypoints{i}(4);

    Dxr = octaves{o, s}(y, x - 1) - octaves{o, s}(y, x + 1);
    Dxl = octaves{o, s}(y, x + 1) - octaves{o, s}(y, x - 1);
    Dyd = octaves{o, s}(y - 1, x) - octaves{o, s}(y + 1, x);
    Dyu = octaves{o, s}(y + 1, x) - octaves{o, s}(y - 1, x);
    Dxx = Dxr * Dxl;
    Dyy = Dyd * Dyu;
    Dxy = Dxr * Dyd;
    TrH = Dxx + Dyy;
    DetH = Dxx * Dyy - Dxy ^ 2;
    if TrH ^ 2 / DetH > (r + 1) ^ 2 / r
        keypoints(i) = [];
    else
        i = i + 1;
    end
end

plotOctavesWithKeypoints(octaves, keypoints, lighthouse);

%% Exercise e)
threshold = 0.1;
i = 1;
while i <= length(keypoints)
    if abs(keypoints{i}(5)) < threshold
        keypoints(i) = [];
    else
        i = i + 1;
    end
end

%% Exercise f)
plotOctavesWithKeypoints(octaves, keypoints, lighthouse);
