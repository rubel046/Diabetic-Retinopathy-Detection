function [ col, row ] = maculadetection_fun(img_od )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

 middle_pos = size(img_od);
    middle_pos_x = middle_pos(1,1)/2;
    middle_pos_y = middle_pos(1,2)/2;
    first_pos_x = 1;
    first_pos_y = middle_pos_x;
    [Label ,Total] = bwlabel(img_od,8);
    [row, col] = find(Label==1);
    X = mean(col);
    Y = mean(row);
    f2m_dist = sqrt(double((first_pos_x-middle_pos_x)^2+(first_pos_y-middle_pos_y)^2));
    f2od_dist = sqrt(double((first_pos_x-X)^2+(first_pos_y-Y)^2));
    row = Y;
    if(f2m_dist > f2od_dist)
        col = X+510;
    else
        col = X-510;
    end
%     figure,imshow(img),title('Fovea Detected');
  %  hold on;
%     r = 30;
%     angle = 0:0.01:2*pi; 
%     xp = r*cos(angle);
%     yp = r*sin(angle);
%     plot(col+xp,row+70+yp,'.g');
    
    
  %  figure,imshow(img),title('Macula Detected');
  %  hold on;
%     r = 80;
%     angle = 0:0.01:2*pi; 
%     xp = r*cos(angle);
%     yp = r*sin(angle);
%     plot(col+xp,row+70+yp,'.g');
end

