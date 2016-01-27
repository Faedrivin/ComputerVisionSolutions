%% Exercise 3)
% For details on how to use imfindcircles take a look at
% http://www.mathworks.com/help/images/examples/detect-and-measure-circular-objects-in-an-image.html

if size(webcamlist, 1) == 0
    cam = '127.0.0.1';
    snap = @(ip) imread(strcat('http://', ip, ':8080/shot.jpg'));
else
    cam = webcam;
    snap = @snapshot;
end

camfig = figure;
    frame = 1;
    hold on;
    while ishandle(camfig)
        image = snap(cam);
        grayimage = rgb2gray(image);

        % TWEAK THESE VALUES according to resolution, image brightness,
        % image section, eye size, etc. - I used 640x480 images and had 
        % close ups of basically only my face in a computer screen lit
        % room. Good luck.
        [centers, radii] = imfindcircles(grayimage, [15 35], ...
                                         'ObjectPolarity', 'dark', ...
                                         'Sensitivity', 0.9, ...
                                         'EdgeThreshold', 0.05);

        if ishandle(camfig)
            imshow(image);
            viscircles(centers, radii);
            title(['Frame ' num2str(frame)])
            frame = frame + 1;
            drawnow
        end
    end

clear cam;
