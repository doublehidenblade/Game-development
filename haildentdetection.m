function varargout = haildentdetection(varargin)
% HAILDENTDETECTION MATLAB code for haildentdetection.fig
%      HAILDENTDETECTION, by itself, creates a new HAILDENTDETECTION or raises the existing
%      singleton*.
%
%      H = HAILDENTDETECTION returns the handle to a new HAILDENTDETECTION or the handle to
%      the existing singleton*.
%
%      HAILDENTDETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HAILDENTDETECTION.M with the given input arguments.
%
%      HAILDENTDETECTION('Property','Value',...) creates a new HAILDENTDETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before haildentdetection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to haildentdetection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help haildentdetection

% Last Modified by GUIDE v2.5 12-Dec-2018 10:32:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @haildentdetection_OpeningFcn, ...
                   'gui_OutputFcn',  @haildentdetection_OutputFcn, ...
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


% --- Executes just before haildentdetection is made visible.
function haildentdetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to haildentdetection (see VARARGIN)

% Choose default command line output for haildentdetection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
homescreen(handles)


function homescreen(handles)
handles.calculate.Visible='off';
handles.axes1.Visible='off';
handles.resultstable.Visible='off';
handles.save.Visible='off';
handles.results.Visible='off';
handles.homescreen.Visible='off';
handles.preprocessing.Visible='off';
handles.dentdetection.Visible='off';
handles.choosedirectory.Visible='on';
handles.selectimage.Visible='on';
handles.automatic.Visible='on';
handles.manual.Visible='on';
handles.savetofile.Visible='off';
rv=[42.2 23.5 42.2 23.5]; %resize values to change from units in cm to percentage from 0-1
handles.automatic.Position=[14.2 5 5 1.8]./rv;
handles.choosedirectory.Position=[12 20 3.7 1.4]./rv;
handles.selectimage.Position=[17 20 14 1]./rv;
handles.manual.Position=[23.4 5 5 1.8]./rv;
handles.axes1.Position=[11.3 7.6 20 12]./rv;
cla; xlabel(''); ylabel(''); title('');


% UIWAIT makes haildentdetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function resultsscreen(handles)
handles.choosedirectory.Visible='off';
handles.selectimage.Visible='off';
handles.automatic.Visible='off';
handles.resultstable.Visible='on';
handles.manual.Visible='on';
handles.save.Visible='on';
handles.results.Visible='on';
handles.homescreen.Visible='on';
handles.axes1.Visible='off';
handles.preprocessing.Visible='off';
handles.dentdetection.Visible='off';
handles.calculate.Visible='off';
handles.savetofile.Visible='off';

rv=[42.2 23.5 42.2 23.5]; 
handles.resultstable.Position=[28 7 12 7]./rv;
handles.manual.Position=[24.7 4.5 5 1.8]./rv;
handles.save.Position=[30.4 4.5 5 1.8]./rv;
handles.results.Position=[36.2 4.5 5 1.8]./rv;
handles.homescreen.Position=[39 1 2 1.5]./rv;
handles.axes1.Position=[2.6 1.9 20 19]./rv;

function manualscreen(handles, varargin)
handles.choosedirectory.Visible='off';
handles.selectimage.Visible='off';
handles.automatic.Visible='off';
handles.preprocessing.Visible='on';
handles.dentdetection.Visible='on';
handles.calculate.Visible='on';
handles.axis1.Visible='on';
handles.manual.Visible='off';
handles.resultstable.Visible='off';
handles.save.Visible='off';
handles.results.Visible='off';
handles.savetofile.Visible='off';

rv=[42.2 23.5 42.2 23.5]; 
handles.preprocessing.Position=[26 15 12 5.6]./rv;
handles.dentdetection.Position=[26 9 12 5.6]./rv;
handles.calculate.Position=[29 6.3 5 1.7]./rv;
handles.axes1.Position=[2.6 1.9 20 19]./rv;

% --- Outputs from this function are returned to the command line.
function varargout = haildentdetection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in choosedirectory.
function choosedirectory_Callback(hObject, eventdata, handles)
% hObject    handle to choosedirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1, 'pointer', 'watch'); drawnow;
folder= uigetdir;
try
    a = dir (folder);
    availableimages = {a(~[a.isdir]).name};
    handles.selectimage.String = ['Select Image', availableimages];
    handles.selectimage.Value = 1;
    handles.choosedirectory.UserData=folder;
end
set(handles.figure1, 'pointer', 'arrow')

% --- Executes on selection change in selectimage.
function selectimage_Callback(hObject, eventdata, handles)
% hObject    handle to selectimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectimage contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectimage
set(handles.figure1, 'pointer', 'watch'); drawnow;
imagenames=handles.selectimage.String;
selectedimage=handles.selectimage.Value;
imagename=char(imagenames(selectedimage));
folder = handles.choosedirectory.UserData;
rv=[42.2 23.5 42.2 23.5]; 
handles.axes1.Position=[11.3 7.6 20 12]./rv;
try 
    image=imread([folder,'\',imagename]);
    imshow(image);
    handles.selectimage.UserData=image;
end;
set(handles.figure1, 'pointer', 'arrow')

% --- Executes on button press in automatic.
function automatic_Callback(hObject, eventdata, handles)
% hObject    handle to automatic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(handles.figure1, 'pointer', 'watch'); drawnow;
 resultsscreen(handles);
 image=handles.selectimage.UserData;
 
 %Default values
 R=25; %Default line width is 25 pixels
 handles.linesize.UserData=R;
 handles.dotsize.UserData=70; %Default value of one inch is 70 pixels
 handles.noiseslider.Value=0.1; %Default value of slider is 10%
 handles.dentslider.Value=0.5; %Default value of dentslider is 50%
 ver=0; hor=0; %Default orientation is neither horizontal nor vertical
 handles.isvertical.Value=ver;
 handles.ishorizontal.Value=hor;
 [xsize,ysize]=size(image);
 if hor==ver; numx=floor(xsize/(4*R)); numy=floor(ysize/(4*R));
 elseif ver; numy=floor(ysize/(4*R)); numx=floor(numy*xsize/ysize);
 elseif hor; numx=floor(xsize/(4*R)); numy=floor(numx*ysize/xsize); end;
 
 handles.numberofrows.String=num2str(numx); 
 handles.numberofcolumns.String=num2str(numy);
 
 binarize_Callback(handles.binarize,[],handles);
 finddents_Callback(handles.finddents,[],handles);
 calculate_Callback(handles.calculate,[], handles);
 
 set(handles.figure1, 'pointer', 'arrow')
 

% --- Executes on button press in linesize.
function linesize_Callback(hObject, eventdata, handles)
% hObject    handle to linesize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,y]=ginput(2); R=floor(sqrt((x(2)-x(1))^2+(y(1)-y(2))^2)/2);
handles.linesize.UserData=R;
image=handles.selectimage.UserData;
ver = handles.isvertical.Value; hor=handles.ishorizontal.Value;
[xsize,ysize]=size(image);
 if hor==ver; numx=floor(xsize/(4*R)); numy=floor(ysize/(4*R));
 elseif ver; numy=floor(ysize/(4*R)); numx=floor(numy*xsize/ysize);
 elseif hor; numx=floor(xsize/(4*R)); numy=floor(numx*ysize/xsize); end;
handles.numberofrows.String=num2str(numx);
handles.numberofcolumns.String=num2str(numy);

% --- Executes on button press in dotsize.
function dotsize_Callback(hObject, eventdata, handles)
% hObject    handle to dotsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,y]=ginput(2); dotdiameter=sqrt((x(2)-x(1))^2+(y(1)-y(2))^2);
handles.dotsize.UserData=dotdiameter;

% --- Executes on button press in binarize.
function binarize_Callback(hObject, eventdata, handles)
% hObject    handle to binarize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.figure1, 'pointer', 'watch'); drawnow;
image=handles.selectimage.UserData;
R=handles.linesize.UserData;
thresh=local_threshold(image,R,0);
handles.binarize.UserData=thresh;
noiseslider_Callback(handles.noiseslider,[],handles);
set(handles.figure1, 'pointer', 'arrow')


% --- Executes on slider movement.
function noiseslider_Callback(hObject, eventdata, handles)
% hObject    handle to noiseslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.figure1, 'pointer', 'watch')
drawnow;
thresh=handles.binarize.UserData;
s=handles.noiseslider.Value;
ver=handles.isvertical.Value;
hor=handles.ishorizontal.Value;
R=handles.linesize.UserData;
if s~=0; 
    if hor==ver; sigma=[s*R/2, s*R/2]; elseif ver; sigma=[s*R, s*R/2]; elseif hor; sigma=[s*R/2, s*R]; end;
cleanthresh=imgaussfilt(thresh,sigma);
[x_size,y_size]=size(thresh);
b=sum(sum(thresh))/(x_size*y_size);
bthresh=cleanthresh>b;
imshow(bthresh);
handles.noiseslider.UserData=bthresh; 
else; 
imshow(thresh);
handles.noiseslider.UserData=thresh;
end;
set(handles.figure1, 'pointer', 'arrow')

% --- Executes on button press in finddents.
function finddents_Callback(hObject, eventdata, handles)
% hObject    handle to finddents (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1, 'pointer', 'watch')
drawnow;
image=handles.noiseslider.UserData;
numx=handles.numberofrows.String; numx=int16(str2double(numx));
numy=handles.numberofcolumns.String; numy=int16(str2double(numy));
dividedImage=image2sections(image,numx,numy);
[dent,theta,dent2]=sections2dent(dividedImage,numx,numy);
handles.finddents.UserData={dent dent2};
dentslider_Callback(handles.dentslider,[],handles);
set(handles.figure1, 'pointer', 'arrow')

% --- Executes on slider movement.
function dentslider_Callback(hObject, eventdata, handles)
% hObject    handle to noiseslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.figure1, 'pointer', 'watch')
drawnow;
D=handles.finddents.UserData;
dents1=D{1}; dents2=D{2};
folder=handles.noiseslider.UserData;
s2=handles.dentslider.Value;
hor=handles.ishorizontal.Value;
ver=handles.isvertical.Value;

%dents=(dents<s2*3 |ar1>1 and  ar1>0.5);
if hor==ver; dents=dents1<s2*30;
elseif ver; dents=dents1<(s2*30) | dents2<s2*10;
elseif hor; dents=dents1<(s2*30) | dents2>s2*10;
end;
handles.dentslider.UserData = dents;

imshow(folder);
hold on
numx=handles.numberofrows.String; numx=int16(str2double(numx));
numy=handles.numberofcolumns.String; numy=int16(str2double(numy));
[x,y]=size(folder);
xdir = y/numy;
ydir = x/numx;
for i = 1:numy
    plot([i*xdir i*xdir], [1, size(folder,1)], 'r', 'Linewidth', 3);
end
for j =1:numx
    plot([1 size(folder,2)], [j*ydir j*ydir], 'r', 'Linewidth', 3);
end

for i = 1:numx
    for j = 1:numy
        if dents (i,j) == 1
            patch([(j-1)*xdir (j)*xdir (j)*xdir (j-1)*xdir],...
                [(i)*ydir (i)*ydir (i-1)*ydir (i-1)*ydir],...
                'cyan','FaceColor','cyan','FaceAlpha',0.4);
        else
            patch([(j-1)*xdir (j)*xdir (j)*xdir (j-1)*xdir],...
                [(i)*ydir (i)*ydir (i-1)*ydir (i-1)*ydir],...
                'blue','FaceColor','blue','FaceAlpha',0.4);
        end
    end
end
xlabel('Green = Dent. Blue = No dent.');
hold off all
set(handles.figure1, 'pointer', 'arrow')

% --- Executes on button press in calculate.
function calculate_Callback(hObject, eventdata, handles)
% hObject    handle to calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resultsscreen(handles)
set(handles.figure1, 'pointer', 'watch')
drawnow;
dents=handles.dentslider.UserData;
[Lw, nw]=bwlabel(dents,4);
dentsizes=ones(nw,1);
for object=1:nw;
    [r,c]= find(Lw==object);
    rc=[r c];
    dentsizes(object)=size(rc,1);
end;
numx=handles.numberofrows.String; numx=(str2double(numx));
numy=handles.numberofcolumns.String; numy=(str2double(numy));
dotdiameter=handles.dotsize.UserData;
folder=handles.noiseslider.UserData;
[x,y]=size(folder);
sizepixelratio=0.955/dotdiameter; %Using the size of a quarter in inches as the standard
dentsizes=dentsizes*(x/numx)*(y/numy);
dentdiameters=sqrt(4/pi*dentsizes)*sizepixelratio; %Calculating the diameter asuming a circular area
%To update resultstable with calculated size of panel
sizes=[0, 0.25,0.5,0.75,1,Inf]; tablesize=length(sizes); dentsizes=zeros(tablesize,1);
for i=1:tablesize-1;
    for j=1:length(dentdiameters);
        if dentdiameters(j) > sizes(i) & dentdiameters(j) < sizes(i+1);
            dentsizes(i) = dentsizes(i)+1;
        end;
    end;
end;
dentsizes(tablesize)=sum(dentsizes(1:tablesize-1));
handles.resultstable.Data=dentsizes;

set(handles.figure1, 'pointer', 'arrow')


% --- Executes during object creation, after setting all properties.
function noiseslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noiseslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function thresholded_image = local_threshold(image,r,c)
%Takes rgb or greyscale image and returns binary image thresholded by
%comparing each pixel with the mean of its neighbors in circle of radius r
%pixels
%r should be chosen to be around 1 line width.
%c is an additional parameter that affects the thresholding step
%afterwards reduces noise with gaussian filter and rethresholds


%Local area: defines pixels less than radius r from center pixel
x_local=zeros((2*r)^2,1); y_local=x_local;
lxy=1;
for i=-r:r; 
    for j=-r:r;
        if i^2+j^2<=r^2;
            x_local(lxy)=i; y_local(lxy)=j; lxy=lxy+1;
        end;
    end;
end;
lxy=lxy-1;
x_local=x_local(1:lxy); y_local=y_local(1:lxy);

%Difference in i direction between two local areas
x_plus_i=zeros((2*r)^2,1); y_plus_i=x_plus_i; x_minus_i=x_plus_i; y_minus_i=x_plus_i; lxyp=1;lxym=1;
for i=-(r+1):r; for j=-r:r;
        if i^2+j^2<=r^2 && ((i+1)^2+j^2>r^2)
            x_plus_i(lxyp)=i; y_plus_i(lxyp)=j; lxyp=lxyp+1; end;
        if i^2+j^2>r^2 && ((i+1)^2+j^2<=r^2)
            x_minus_i(lxym)=i; y_minus_i(lxym)=j; lxym=lxym+1; end;    
        end;end;
    lxyp=lxyp-1; lxym=lxym-1;
x_plus_i=x_plus_i(1:lxyp); y_plus_i=y_plus_i(1:lxyp); x_minus_i=x_minus_i(1:lxym); y_minus_i=y_minus_i(1:lxym);


%tranform image to grayscale
if length(size(image))==3; image=rgb2gray(image); end;
[x_size,y_size]=size(image);

%mirror image about edges so that edges don't return errors
expandedimagex=[image(r+1:-1:2,:);image;image(x_size-1:-1:x_size-r,:)];
expandedimage=[expandedimagex(:,r+1:-1:2),expandedimagex,expandedimagex(:,y_size-1:-1:y_size-r)];

thresholded_image=zeros(x_size,y_size);
%initialize first mean
localmeanx=0;
for k=1:lxy;
    x=1+x_local(k); y=1+y_local(k);
    localmeanx=localmeanx+double(expandedimage(x+r,y+r)); end;
%looping through each pixel
for i=1:x_size;
    %updates mean for first pixel of each x row
    localmean=localmeanx;
    if i>1;
        for k=1:lxyp;
            x=i+x_plus_i(k); y=1+y_plus_i(k);
            localmean=localmean+double(expandedimage(x+r,y+r));
        end;
        for k=1:lxym;
            x=i+x_minus_i(k); y=1+y_minus_i(k);
            localmean=localmean-double(expandedimage(x+r,y+r));
        end;
    end;
    localmeanx=localmean;
    for j=1:y_size;
        %updates mean for each pixel of y row
        if j>1;
            for k=1:lxyp;
                xp=i+y_plus_i(k); yp=j+x_plus_i(k); xm=i+y_minus_i(k); ym=j+x_minus_i(k);
                localmean=localmean+double(expandedimage(xp+r,yp+r))-double(expandedimage(xm+r,ym+r));
            end;
        end;
        %thresholds each pixel using calculated mean for its neighborhood
        thresholded_image(i,j)=image(i,j)>localmean/lxy+c;
    end;
end;


% --- Executes during object creation, after setting all properties.
function dentslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noiseslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function dividedImage = image2sections(img, rows, columns)
    R = zeros(1,rows); 
    cellSizeRow = floor(size(img,1)/rows);
    for i = 1:(rows-1)
         R(i)= cellSizeRow;
    end
    R(1,rows)=size(img,1)-(cellSizeRow*(rows-1));
    
   
    C = zeros(1,columns);
    cellSizeCol = floor(size(img,2)/columns);
    for j = 1:(columns-1)
         C(j)= cellSizeCol;
    end
    C(1,columns)=size(img,2)-(cellSizeCol*(columns-1));
    
    dividedImage = mat2cell(img,R,C);
    
function [dents, theta, dents2] = sections2dent(dividedImage, rows, columns)

    dents = zeros(rows,columns); dents2=dents;
    for k = 1:rows
        for l = 1:columns
            SubImg1 = dividedImage{k,l};
            F1 = fft2(SubImg1);
            Fsh1 = abs(fftshift(F1));
            thresh1 = 1;
            while size(find(Fsh1>thresh1),1)>0.1*sum(sum(Fsh1*0+1));
                thresh1=thresh1+1;
            end;
            Mf1 = Fsh1 > thresh1;
            [dents(k,l),theta,dents2(k,l)]=ellipse1(Mf1,0.95);
        end
   end


% --- Executes on button press in isvertical.
function isvertical_Callback(hObject, eventdata, handles)
% hObject    handle to isvertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of isvertical
if handles.isvertical.Value==1; handles.ishorizontal.Value=0; end;

% --- Executes on button press in ishorizontal.
function ishorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to ishorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ishorizontal
if handles.ishorizontal.Value==1; handles.isvertical.Value=0; end;


function numberofrows_Callback(hObject, eventdata, handles)
% hObject    handle to numberofrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberofrows as text
%        str2double(get(hObject,'String')) returns contents of numberofrows as a double


% --- Executes during object creation, after setting all properties.
function numberofrows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberofrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numberofcolumns_Callback(hObject, eventdata, handles)
% hObject    handle to numberofcolumns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numberofcolumns as text
%        str2double(get(hObject,'String')) returns contents of numberofcolumns as a double


% --- Executes during object creation, after setting all properties.
function numberofcolumns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numberofcolumns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function selectimage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in manual.
function manual_Callback(hObject, eventdata, handles)
manualscreen(handles)
image=handles.selectimage.UserData;
imshow(image)
% hObject    handle to manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.resultstable.UserData=[handles.resultstable.UserData, handles.resultstable.Data];

% --- Executes on button press in home.
function home_Callback(hObject, eventdata, handles)
 homescreen(handles)
% hObject    handle to home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in results.
function results_Callback(hObject, eventdata, handles)
% hObject    handle to results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.resultstable.Data=handles.resultstable.UserData;
rv=[42.2 23.5 42.2 23.5]; 
handles.resultstable.Position=[24 7 18 7]./rv;
handles.savetofile.Visible='on';
handles.manual.Visible='off';
handles.save.Visible='off';
handles.results.Visible='off';


% --- Executes on button press in savetofile.
function savetofile_Callback(hObject, eventdata, handles)
% hObject    handle to savetofile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,path]=uiputfile('*.csv','','dentsizes.csv');
try; csvwrite([path,'\',filename],handles.resultstable.UserData); end;

function [AR, angle, AR1] = ellipse1(Mf1,confidence)

[col10,row10] = find(Mf1);
y1 = -row10;
y2 = col10;
data = [y1 y2];

try;
% Calculate the eigenvectors and eigenvalues
covariance = cov(data);
[eigenvec, eigenval ] = eig(covariance);

% Get the index of the largest eigenvector
[largest_eigenvec_ind_c, r] = find(eigenval == max(max(eigenval)));
largest_eigenvec = eigenvec(:, largest_eigenvec_ind_c);

% Get the largest eigenvalue
largest_eigenval = max(max(eigenval));

% Get the smallest eigenvector and eigenvalue
if(largest_eigenvec_ind_c == 1)
    smallest_eigenval = max(eigenval(:,2))
    smallest_eigenvec = eigenvec(:,2);
else
    smallest_eigenval = max(eigenval(:,1));
    smallest_eigenvec = eigenvec(1,:);
end

% Calculate the angle between the x-axis and the largest eigenvector
angle = atan2(largest_eigenvec(2), largest_eigenvec(1));

% This angle is between -pi and pi.
% Let's shift it such that the angle is between 0 and 2pi
if(angle < 0)
    angle = angle + 2*pi;
end

%Finding Aspect Ratio
x = largest_eigenval*cos(angle);
y = smallest_eigenval*cos((pi/2)-angle);
AR1=abs(x/y); 
AR=abs(largest_eigenval/smallest_eigenval);

catch;
    AR=NaN; AR1=NaN; angle=NaN;
end;
