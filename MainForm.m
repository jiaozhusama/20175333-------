function varargout = MainForm(varargin)
% MAINFORM MATLAB code for MainForm.fig
%      MAINFORM, by itself, creates a new MAINFORM or raises the existing
%      singleton*.
%
%      H = MAINFORM returns the handle to a new MAINFORM or the handle to
%      the existing singleton*.
%
%      MAINFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFORM.M with the given input arguments.
%
%      MAINFORM('Property','Value',...) creates a new MAINFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainForm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainForm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainForm

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MainForm_OpeningFcn, ...
    'gui_OutputFcn',  @MainForm_OutputFcn, ...
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

function InitAxes(handles)
clc;
axes(handles.axes1); cla reset; axis on; box on;
set(gca, 'XTickLabel', '', 'YTickLabel', '');
axes(handles.axes2); cla reset; axis on; box on;
set(gca, 'XTickLabel', '', 'YTickLabel', '');
axes(handles.axes3); cla reset; axis on; box on;
set(gca, 'XTickLabel', '', 'YTickLabel', '');

% --- Executes just before MainForm is made visible.
function MainForm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainForm (see VARARGIN)

% Choose default command line output for MainForm
handles.output = hObject;
InitAxes(handles)
handles.I = 0;
handles.ambtc_c = 0;
handles.ambtc_en = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainForm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainForm_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function filePath = OpenImageFile(imgfilePath)
% 打开文件
% 输出参数：
% filePath——文件路径

if nargin < 1
    imgfilePath = fullfile(pwd, 'images/lena.bmp');
end
% 读取文件
[filename, pathname, ~] = uigetfile( ...
    { '*.bmp;*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*',  '所有文件 (*.*)'}, ...
    '选择文件', ...
    'MultiSelect', 'off', ...
    imgfilePath);
filePath = 0;
if isequal(filename, 0) || isequal(pathname, 0)
    return;
end
filePath = fullfile(pathname, filename);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filePath = OpenImageFile();
if isequal(filePath, 0)
    return;
end
InitAxes(handles)
I = imread(filePath);
axes(handles.axes1); cla reset;
imshow(I, []);
title('原图像');
handles.I = I;
handles.filename = filePath;
guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.I, 0)
    return;
end
[handles.ambtc_r,handles.ambtc_c,handles.ambtc_d] = ambtc_transform(handles.I);
guidata(hObject, handles);
questdlg('完毕！', ...
    '提示', ...
    '确定','确定');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.ambtc_c,0)
    return;
end
ambtc_c = handles.ambtc_c;
md = rand(size(ambtc_c,1), size(ambtc_c,2));
md(md >= 0.5) = 1;
md(md < 0.5) = 0;
[ambtc_ad,ambtc_en] = ambtc_encryption(ambtc_c,handles.ambtc_d,md);
axes(handles.axes2); cla reset;
imshow(ambtc_en, []);
title('隐藏图像');
handles.ambtc_ad = ambtc_ad;
handles.ambtc_en = ambtc_en;
guidata(hObject, handles);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(handles.ambtc_en,0)
    return;
end
ambtc_de = ambtc_decryption(handles.ambtc_en, handles.ambtc_ad);
axes(handles.axes3); cla reset;
imshow(ambtc_de, []);
title('还原图像');

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
choice = questdlg('确定要退出?', ...
    '退出', ...
    '确定','取消','取消');
switch choice
    case '确定'
        close;
    case '取消'
        return;
end
