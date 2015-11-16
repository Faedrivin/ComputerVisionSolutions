function [ IMG_CROPPED_RECTANGLE ] = cropRectangle( IMG, x, y, w, h )
    IMG_CROPPED_RECTANGLE = IMG(y:y+h,x:x+w);
end