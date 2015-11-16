function [ IMG_WITH_RECTANGLE ] = markRectangle( IMG, x, y, w, h )
    mask = ones(size(IMG));
    mask(y:y+h-1,x) = 0;
    mask(y:y+h-1,x+w-1) = 0;
    mask(y,x:x+w-1) = 0;
    mask(y+h-1,x:x+w-1) = 0;
    IMG_WITH_RECTANGLE = IMG.*uint8(mask) + uint8((ones(size(IMG))-mask)*255);
end

