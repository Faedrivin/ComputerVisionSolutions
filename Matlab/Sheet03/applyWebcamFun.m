function image = applyWebcamFun( imagefuns, url )
%APPLYWEBCAMFUNS

    % Determine existing webcam. If none found, use IP Webcam.
    if size(webcamlist, 1) == 0
        webcam = url;
        snap = @(ip) imread(strcat('http://', ip, ':8080/shot.jpg'));
    else
        snap = @snapshot;
    end
    
    % Acquire cam
    cam = webcam;

    frame = 1;
    fig = figure;
        hold on;
        while ishandle(fig)
            image = imagefuns(snap(cam));
            if ishandle(fig)
                imshow(image)
                title(['Frame ' num2str(frame)])
                frame = frame + 1;
                drawnow
            end
        end
        
    clear cam;

end

