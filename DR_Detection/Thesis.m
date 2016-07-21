function varargout = Thesis(varargin)

% THESIS MATLAB code for Thesis.fig
%      THESIS, by itself, creates a new THESIS or raises the existing
%      singleton*.
%
%      H = THESIS returns the handle to a new THESIS or the handle to
%      the existing singleton*.
%
%      THESIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THESIS.M with the given input arguments.
%
%      THESIS('Property','Value',...) creates a new THESIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Thesis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Thesis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Thesis

% Last Modified by GUIDE v2.5 18-Jan-2016 03:04:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Thesis_OpeningFcn, ...
                   'gui_OutputFcn',  @Thesis_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
     
end
% End initialization code - DO NOT EDIT


% --- Executes just before Thesis is made visible.
function Thesis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Thesis (see VARARGIN)

% Choose default command line output for Thesis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Thesis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Thesis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


 

% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img h
img=loadimg_fun();
axes(handles.axes1);
imshow(img);
title('Original Image');
%clear previous axes...............
if ishandle(h)
     delete(h);
 end
 clear h;
cla(handles.axes2,'reset');
set(handles.axes2,'xtick',[],'ytick',[]);
cla(handles.axes3,'reset');
set(handles.axes3,'xtick',[],'ytick',[]);
cla(handles.axes4,'reset');
set(handles.axes4,'xtick',[],'ytick',[]);
cla(handles.axes5,'reset');
set(handles.axes5,'xtick',[],'ytick',[]);
cla(handles.axes6,'reset');
set(handles.axes6,'xtick',[],'ytick',[]);

% --- Executes on button press in execute.
function execute_Callback(hObject, eventdata, handles)
% hObject    handle to execute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%preprocessing................
global img img_adap img_od img1 BW2 final_img n_od h
img_adap=preprocessing_fun(img);
axes(handles.axes2);
imshow(img_adap);
title('Preprocessed Image');
 
 %optic disc detection.............
img_od=ODdetection_fun(img_adap);
axes(handles.axes3);
imshow(img_od);
title('OD Detection');
[x,y]=find(img_od==1);
n_od=[x,y];

%vessels detection............
BW2=vesselsdetection_fun( img );
axes(handles.axes4);
imshow(BW2);
title('Vessels Detection');

%macula detection............
img1=img;
[col, row]=maculadetection_fun(img_od );
colrow=[col, row];
axes(handles.axes5);
imshow(img1),title('Macula Detection');
   hold on;
    r = 80;
    angle = 0:0.01:2*pi; 
    xp = r*cos(angle);
    yp = r*sin(angle);
    plot(colrow(1,1)+xp,colrow(1,2)+70+yp,'g');
 
%MA detection............
final_img=madetection_fun( img_adap,n_od );
axes(handles.axes6);
imshow(final_img);
title('MA Detection');
[x,y]=find(final_img==1);
n_msg=[x,y];
TF = isempty(n_msg);
healthy_icon = imread('.\icon\healthy.jpg');
doctor_icon = imread('.\icon\doctor.png');

if( TF==true)
    h= msgbox('Healthy Eye','','custom',healthy_icon);
else
    h=msgbox('Retinopathy Eye (MA Detected)','','custom',doctor_icon);
end


% --- Executes on button press in optic_disc.
function optic_disc_Callback(hObject, eventdata, handles)
% hObject    handle to optic_disc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img_od img
 [B,L] = bwboundaries(img_od,'noholes');
% Display the label matrix and draw each boundary
figure,imshow(img);
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 1);
end

title('Optic Disc Detected');


% --- Executes on button press in fovea.
function fovea_Callback(hObject, eventdata, handles)
% hObject    handle to fovea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Display the label matrix and draw each boundary
global img1 img img_od
img1=img;
[col, row]=maculadetection_fun(img_od );
colrow=[col, row];
figure, imshow(img1),title('Macula Detected');
   hold on;
    r = 80;
    angle = 0:0.01:2*pi; 
    xp = r*cos(angle);
    yp = r*sin(angle);
    plot(colrow(1,1)+xp,colrow(1,2)+70+yp,'g');

% --- Executes on button press in blood_vessels.
function blood_vessels_Callback(hObject, eventdata, handles)
% hObject    handle to blood_vessels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global BW2
figure, imshow(BW2),title('Blood Vessels Detected');

% --- Executes on button press in microaneurysm.
function microaneurysm_Callback(hObject, eventdata, handles)
% hObject    handle to microaneurysm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global final_img img
 [B,L] = bwboundaries(final_img,'noholes');

% Display the label matrix and draw each boundary
figure,imshow(img);
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 1);
end

stats = regionprops(L,'Area','Centroid');

threshold = 0.94;

% loop over the boundaries
for k = 1:length(B)

  % obtain (X,Y) boundary coordinates corresponding to label 'k'
  boundary = B{k};

  % compute a simple estimate of the object's perimeter
  delta_sq = diff(boundary).^2;
  perimeter = sum(sqrt(sum(delta_sq,2)));

  % obtain the area calculation corresponding to label 'k'
  area = stats(k).Area;

  % compute the roundness metric
  metric = 4*pi*area/perimeter^2;

  % display the results
  %metric_string = sprintf('%2.2f',metric);

  % mark objects above the threshold with a black circle
  if metric > threshold
    centroid = stats(k).Centroid;
   plot(centroid(1),centroid(2),'go');
   
  % for i=1:size(boundary)

  %  pos_x=boundary(i,1);
   % pos_y=boundary(i,2);
    
       % greenPlane(pos_x,pos_y)=255;
   % end
   
  end

  %text(boundary(1,2)-35,boundary(1,1)+13,metric_string,'Color','y',...
      % 'FontSize',14,'FontWeight','bold');

end

title('Microaneurysms Detected');
%figure,imshow(greenPlane);
