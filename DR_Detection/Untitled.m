I = imread('20051020_45137_0100_PP.tif');
% imshow(I);
green_cnl = I(:, :, 2);
K = imadjust(green_cnl,[0.13 0.3],[]);
figure
imshow(K);

img_adap = adapthisteq(K);
figure
imshow(img_adap);

se = strel('disk',15);
close_img = imclose(img_adap,se);
%  figure, imshow(close_img),title('Closeing');

sub=imsubtract(close_img,img_adap);
%  figure, imshow(sub),title('Subtract');

BW = im2bw(sub,0.1);
% figure,imshow(BW),title('Binary');
BW2 = bwareaopen(BW, 500);
figure,imshow(BW2),title('last line');
