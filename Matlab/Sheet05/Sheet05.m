close all;

%% Exercise 1
% a)
peppers = im2double(imread('../../images/peppers.png'));
% peppers = rand(256, 256, 3);
peppersData = reshape(peppers, numel(peppers)/3, []);
figure;
    subplot(1, 3, 1);
        imshow(peppers);
        title(['Image (' num2str(size(peppers, 1)) 'x' num2str(size(peppers, 2)) 'x' num2str(size(peppers, 3)) ')'])
        
    subplot(1, 3, 2);
        scatter3(peppersData(:,1), peppersData(:,2), peppersData(:,3), 5, peppersData);
        %axis([0 1 0 1 0 1])
        title(['RGB cube (' num2str(numel(peppers(:,:,1))) ' pixels)']);
        
    % b)
    subplot(1, 3, 3);
        peppersDataHSV = convertToConeCoords(rgb2hsv(peppersData));
        scatter3(peppersDataHSV(:,1), peppersDataHSV(:,2), peppersDataHSV(:,3), 5, peppersData);
        %axis([-1 1 -1 1 0 1])
        title(['HSV cone (' num2str(numel(peppers(:,:,1))) ' pixels)']);

%% Exercise 2
% a)
peppers = im2double(imread('../../images/peppers.png'));
kmeansPlot(peppers, 5, eps, 1);

%% b)

%% c)
peppers = im2double(imread('../../images/peppers.png'));
figure;
    subplot(2, 5, 1);
        imshow(peppers);
        title(['Image Original (' num2str(size(peppers, 1)) 'x' num2str(size(peppers, 2)) 'x' num2str(size(peppers, 3)) ')'])
        drawnow
        
    for K = 2:10
        [~, centers, ~, ~, kStar] = kmeansClustering(peppers, K, eps, 0);
        subplot(2, 5, K);
            imshow(reshape(centers(kStar,:),size(peppers)));
            title(['K = ' num2str(K)])
        drawnow
    end

%% d)
peppers = rgb2hsv(im2double(imread('../../images/peppers.png')));
K = 5;
figure;
    subplot(2,4,5);
        imshow(hsv2rgb(peppers));
        title('Original')
        drawnow
        
    subplot(2,4,1);
        peppersData = convertToConeCoords(reshape(peppers, numel(peppers)/3, []));
        tic,[~, centers, ~, ~, kStar] = kmeansClustering(reshape(peppersData, size(peppers)), K, eps, 0);toc
        imshow(reshape(centers(kStar,:),size(peppers)));
        title(['HSV, K = ' num2str(K)])
        drawnow
    
    subplot(2,4,2);
        peppersSV = peppers;
        peppersSV(:,:,1) = 0.5;
        peppersData = convertToConeCoords(reshape(peppersSV, numel(peppersSV)/3, []));
        tic,[~, centers, ~, ~, kStar] = kmeansClustering(reshape(peppersData, size(peppers)), K, eps, 0);toc
        imshow(reshape(centers(kStar,:),size(peppers)));
        title(['SV, K = ' num2str(K)])
        drawnow

    subplot(2,4,3);
        peppersHV = peppers;
        peppersHV(:,:,2) = 0.5;
        peppersData = convertToConeCoords(reshape(peppersHV, numel(peppersHV)/3, []));
        tic,[~, centers, ~, ~, kStar] = kmeansClustering(reshape(peppersData, size(peppers)), K, eps, 0);toc
        imshow(reshape(centers(kStar,:),size(peppers)));
        title(['HV, K = ' num2str(K)])
        drawnow
    
    subplot(2,4,4);
        peppersHS = peppers;
        peppersHS(:,:,3) = 0.5;
        peppersData = convertToConeCoords(reshape(peppersHS, numel(peppersHS)/3, []));
        tic,[~, centers, ~, ~, kStar] = kmeansClustering(reshape(peppersData, size(peppers)), K, eps, 0);toc
        imshow(reshape(centers(kStar,:),size(peppers)));
        title(['HS, K = ' num2str(K)])
        drawnow
        
    subplot(2,4,6);
        peppersSV = peppers;
        peppersSV(:,:,[2 3]) = 0.5;
        peppersData = convertToConeCoords(reshape(peppersSV, numel(peppersSV)/3, []));
        tic,[~, centers, ~, ~, kStar] = kmeansClustering(reshape(peppersData, size(peppers)), K, eps, 0);toc
        imshow(reshape(centers(kStar,:),size(peppers)));
        title(['H, K = ' num2str(K)])
        drawnow

    subplot(2,4,7);
        peppersHV = peppers;
        peppersHV(:,:,[1 3]) = 0.5;
        peppersData = convertToConeCoords(reshape(peppersHV, numel(peppersHV)/3, []));
        tic,[~, centers, ~, ~, kStar] = kmeansClustering(reshape(peppersData, size(peppers)), K, eps, 0);toc
        imshow(reshape(centers(kStar,:),size(peppers)));
        title(['S, K = ' num2str(K)])
        drawnow
    
    subplot(2,4,8);
        peppersHS = peppers;
        peppersHS(:,:,[1 2]) = 0.5;
        peppersData = convertToConeCoords(reshape(peppersHS, numel(peppersHS)/3, []));
        tic,[~, centers, ~, ~, kStar] = kmeansClustering(reshape(peppersData, size(peppers)), K, eps, 0);toc
        imshow(reshape(centers(kStar,:),size(peppers)));
        title(['V, K = ' num2str(K)])
        drawnow

%% e)
K = 5;
cam = webcam;
if length(cam.AvailableResolutions) > 1
    cam.Resolution = cam.AvailableResolutions{length(cam.AvailableResolutions)/2};
end
disp(['Camera resolution is ' cam.Resolution])

f = figure;
while ishandle(f)
    image = im2double(snapshot(cam));
    [~, centers, ~, ~, kStar] = kmeansClustering(image, K, 0.1, 0);
    if ishandle(f)
        subplot(1,2,1)
            imshow(image)
            drawnow
        subplot(1,2,2)
            imshow(reshape(centers(kStar,:),size(image)));
            drawnow
    end
end
clear cam;
