function plothough(bwimages, houghtransform)
% PLOTHOUGH Plots a number of black and white images and their 
%   corresponding hough transformations.
%   Images should be a NxRxC matrix, where N is the number of images
%   and RxC are the respective bw image data.

    if nargin < 2
        houghtransform = @hough;
    end
    
    subpltcols = size(bwimages, 1);
    figure;
        for i = 1 : subpltcols
            subplot(2, subpltcols, i);
                imshow(squeeze(bwimages(i,:,:)));
            subplot(2, subpltcols, subpltcols + i);
                [H, theta, rho] = houghtransform(squeeze(bwimages(i,:,:)));
                imshow(imadjust(mat2gray(H)), 'XData', theta, 'YData', rho);
                xlabel('\theta'), ylabel('\rho');
                axis on, axis normal;
            drawnow
        end
end