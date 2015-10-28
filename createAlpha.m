function [alphaMatrix] = createAlpha(warpedImage)
%CREATEALPHA Summary of this function goes here
%   Detailed explanation goes here
    [height, width, depth] = size(warpedImage);
    tempImage = zeros(height, width, depth);
    %Create border of ones
    tempImage(1,:,:) = 1;
    tempImage(height,:,:) = 1;
    tempImage(:,1,:) = 1;
    tempImage(:,width,:) = 1;
    %Make weight
    tempImage = bwdist(tempImage, 'euclidean');
    tempImage(1,:,:) = 1;
    tempImage(height,:,:) = 1;
    tempImage(:,1,:) = 1;
    tempImage(:,width,:) = 1;
    centerPtValue = tempImage(uint8((height/2)), uint8((width/2)));
    weightImage = zeros(height,width,depth);
    %Adjust weight (0,1]
    for x=1:height
       for y=1:width
           weightImage(x,y,:) = tempImage(x,y,:)/centerPtValue;
       end
    end
    alphaMatrix = weightImage;
end

