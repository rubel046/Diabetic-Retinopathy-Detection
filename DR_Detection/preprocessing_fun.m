function [ img_adap ] = preprocessing_fun( img )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%green channel image
green_cnl = img(:, :, 2);
%figure, imshow(green_cnl),title('green channel image');

%image adjust
img_imadjust = imadjust(green_cnl);
%figure, imshow(img_imadjust),title('Imadjust image');

% median filtering
img_filter = medfilt2(img_imadjust);
%figure, imshow(img_filter),title('filtering image');

% adaphistogram technique
img_adap = adapthisteq(img_filter);
%figure, imshow(img_adap),title('adp_histo image');

end

