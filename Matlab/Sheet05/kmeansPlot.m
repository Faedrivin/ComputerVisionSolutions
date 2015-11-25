function clusteredImage = kmeansPlot( image, K, epsilon, animate )
    imageData = reshape(image, numel(image)/size(image, 3), []);
    tic
    [~, centers, steps, ~, kStar] = kmeansClustering(image, K, epsilon, animate);
    toc
    clusteredImage = reshape(centers(kStar,:),size(image));
    figure;
        subplot(1, 3, 1);
            imshow(image);
            title(['Image (' num2str(size(image, 1)) 'x' num2str(size(image, 2)) 'x' num2str(size(image, 3)) ')'])
        subplot(1, 3, 2);
            scatter3(imageData(:,1), imageData(:,2), imageData(:,3), 5, centers(kStar',:));
            hold on;
            scatter3(centers(:,1), centers(:,2), centers(:,3), 500, centers((1:K)',:), 'x');
            hold off;
            title(['k-Means clustering, K=' num2str(K) ' eps=' num2str(epsilon) ' steps=' num2str(steps)]);
        subplot(1, 3, 3);
            imshow(clusteredImage);
            title(['Image cluster colors (' num2str(size(image, 1)) 'x' num2str(size(image, 2)) 'x' num2str(size(image, 3)) ')'])
	drawnow
end

