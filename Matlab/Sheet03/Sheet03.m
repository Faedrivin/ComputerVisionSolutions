%% Exercise 1

% replacement for missing webcam:
url = '127.0.0.1'; % replace with mobile phone IP
%% just show the normal image as a stream
applyWebcamFun(@(x) x, url);

%% a)
% This defines a threshold for the red color channel and applies it. 
% The result is a binary image showing 1s where we expect the object to be.
% This binary image is our mask.
applyWebcamFun(@maskRGB, url);

%% b) 
% The same as a) but in HSV.
applyWebcamFun(@maskHSV, url);

%% c)
% RGB + open
applyWebcamFun(@findBiggestRegion, url);

%% d)
applyWebcamFun(@markObject, url);

%% e)
applyWebcamFun(@trackObject, url);
% clean up the trajectory
clear trackObject;

%% Exercise 2

