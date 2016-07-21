function [img_od ] = ODdetection_fun( img_adap )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here


% Erision technique
se1 = strel('disk',5);        
img_eroded = imerode(img_adap,se1);
% figure, imshow(img_eroded), title('image erision');

% closing technique
se = strel('disk',70);
img_close = imclose(img_eroded,se);
%figure, imshow(img_close),title('image closeing');

% closing technique
%se3 = strel('disk',70);
img_open = imopen(img_close,se);
% figure, imshow(img_open),title('image opening ');

% binary image
img_od = im2bw(img_open,0.93);
% figure,imshow(img_od),title('optic disk detected');

end

