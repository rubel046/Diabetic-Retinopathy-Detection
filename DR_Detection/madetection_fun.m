function [ final_img ] = madetection_fun( img_adap,n_od )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

se = strel('disk',15);
close_img = imclose(img_adap,se);
%figure, imshow(close_img),title('Closeing');


img_sub=imsubtract(close_img,img_adap);
%figure, imshow(img_sub),title('Subtract');
 
 level=graythresh(img_sub);
 img_BW = im2bw(img_sub,level);
%figure,imshow(img_BW),title('Binary image using graythresh');

%%%%%%%%%%%%%%

BW_10_test = bwareaopen(img_BW,150);
%figure,imshow(BW_10_test),title('without bessels.................');

[xx,yy]=find(BW_10_test==1);
nn=[xx,yy];

img_BW_test=im2bw(img_sub,0.14);
%figure,imshow(img_BW_test),title('create binary image using 0.15');


%%%%%%%%%%
  



img_BW_filter = medfilt2(img_BW_test);            
%figure,imshow(img_BW_filter),title('Median Filtering');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% BW_filter_100 = bwareaopen(img_BW_filter,100);
%figure,imshow(BW2),title('last line');

% [x,y]=find(BW_filter_100==1);
% n=[x,y];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


BW_10 = bwareaopen(img_BW_filter,10);
%figure,imshow(BW2),title('last line');

BW_100 = bwareaopen(img_BW_filter,100);
%figure,imshow(BW_100),title('last line2');

img1_BW=imsubtract(BW_10,BW_100);
%figure,imshow(img1_BW),title('binary img1 using size 10 to 100');


for i=1:size(nn)

    pos_x=nn(i,1);
    pos_y=nn(i,2);
    img1_BW(pos_x,pos_y)=0;
end
% figure,imshow(img1_BW),title('Binary img1 without vassels pixels');

%%%%%%%
% test1=img_adap;
% test2=img_adap;
% test3=img_adap;

% [x,y]=find(img1_BW==1);
% n=[x,y];
% 
% for i=1:size(n)
% 
%     pos_x=n(i,1);
%     pos_y=n(i,2);
%     test1(pos_x,pos_y)=255;
% end
% figure, imshow(test1),title('img1 check');


%%%%%%%

% for i=1:size(n)
% 
%     pos_x=n(i,1);
%     pos_y=n(i,2);
%     
%          img1_BW(pos_x,pos_y)=0;
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test1=img_adap;
% 
% test2=img_adap;
% [x11,y11]=find(img1_BW==1);
% n11=[x11,y11];
% 
% for i=1:size(n11)
% 
%     pos_x=n11(i,1);
%     pos_y=n11(i,2);
%     
%          test1(pos_x,pos_y)=255;
% end

%figure,imshow(test1),title('img1 check');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 img_imadjust_sub = img_sub;
%figure, imshow(img_imadjust_sub),title('img_imadjust_sub');


[x1,y1]=find(img_imadjust_sub>=58 & img_imadjust_sub<=155);
n1=[x1,y1];

img2=zeros(size(img_adap));

for i=1:size(n1)

    pos_x=n1(i,1);
    pos_y=n1(i,2);
    
        img2(pos_x,pos_y)=1;
%    test3(pos_x,pos_y)=255;

    
end

img2_filter=medfilt2(img2);
%figure, imshow(img2_filter),title('im2 using color');

%img2_filter_100 = bwareaopen(img2_filter,100);
%figure,imshow(BW2),title('last line');

%[x2,y2]=find(img2_filter_100==1);
%n2=[x2,y2];



BW2_10 = bwareaopen(img2_filter,10);
%figure,imshow(BW2),title('last line');

BW2_100 = bwareaopen(img2_filter,100);
%figure,imshow(BW3),title('last line2');

img2_BW=imsubtract(BW2_10,BW2_100);
% figure,imshow(img2_BW),title('img2 with noise');

for i=1:size(nn)

    pos_x=nn(i,1);
    pos_y=nn(i,2);
    img2_BW(pos_x,pos_y)=0;
end

% figure,imshow(img2_BW),title('img2 with out noise');

%%%%%%%%%%%%%%%%

% [x5,y5]=find(img2_BW==1);
% n5=[x5,y5];
% 
% for i=1:size(n5)
% 
%     pos_x=n5(i,1);
%     pos_y=n5(i,2);
%     test2(pos_x,pos_y)=255;
% end
%figure, imshow(test2),title('img2 check');

%%%%%%%%%%%%%%%%
%figure,imshow(img2_BW),title('Binary img2 using color and size 10 to 100');
% for i=1:size(n)
% 
%     pos_x=n(i,1);
%     pos_y=n(i,2);
%     img2_BW(pos_x,pos_y)=0;
% end
%figure, imshow(img2_BW),title('binary image 2');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [x11,y11]=find(img2_BW==1);
% n11=[x11,y11];
% 
% for i=1:size(n11)
% 
%     pos_x=n11(i,1);
%     pos_y=n11(i,2);
%     test2(pos_x,pos_y)=255;
% end

%figure,imshow(test2),title('img2 check');
%%%%%%%%%%%%%%%%%%%%%%%

final_img=zeros(size(img_adap));


img_add=imadd(img1_BW,img2_BW,'uint8');


[x3,y3]=find(img_add==2);
n3=[x3,y3];


for i=1:size(n3)

    pos_x=n3(i,1);
    pos_y=n3(i,2);
    final_img(pos_x,pos_y)=1;
    

end

img_mask=imread('.\icon\mask.png');
img_mask=im2bw(img_mask);
    [xmask,ymask]=find(img_mask==0);
    nmask=[xmask,ymask];



 for i=1:size(nmask)

    x=nmask(i,1);
    y=nmask(i,2);
    final_img(x,y)=0;
  end 
 
%  figure,imshow(final_img),title('MA Detection');

%optic disc pixels elimination
for i=1:size(n_od)

    pos_x=n_od(i,1);
    pos_y=n_od(i,2);
    final_img(pos_x,pos_y)=0;


    
end

end

