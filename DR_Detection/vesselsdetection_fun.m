function [ BW2 ] = vesselsdetection_fun( img )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

greenPlane = img(:, :, 2);
%figure, imshow(greenPlane),title('Green channel');
 
img_imadjust = imadjust(greenPlane);
% figure, imshow(img_imadjust),title('Imadjust');

% BW1 = im2bw(greenPlane);
% figure,imshow(BW1),title('Binary');
% 
img_adhisteq = adapthisteq(img_imadjust);
%  figure, imshow(img_adhisteq),title('Adhisteq');

se = strel('disk',15);
close_img = imclose(img_adhisteq,se);
%  figure, imshow(close_img),title('Closeing');

sub=imsubtract(close_img,img_adhisteq);
%  figure, imshow(sub),title('Subtract');

BW = im2bw(sub,0.2);
% figure,imshow(BW),title('Binary');
BW2 = bwareaopen(BW, 500);
%figure,imshow(BW2),title('last line');

end

