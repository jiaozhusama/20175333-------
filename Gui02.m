function varargout = Gui02(varargin)
% GUI02 MATLAB code for Gui02.fig
%      GUI02, by itself, creates a new GUI02 or raises the existing
%      singleton*.
%
%      H = GUI02 returns the handle to a new GUI02 or the handle to
%      the existing singleton*.
%
%      GUI02('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI02.M with the given input arguments.
%
%      GUI02('Property','Value',...) creates a new GUI02 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui02_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui02_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui02

% Last Modified by GUIDE v2.5 23-Apr-2021 22:26:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui02_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui02_OutputFcn, ...
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


% --- Executes just before Gui02 is made visible.
function Gui02_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui02 (see VARARGIN)

% Choose default command line output for Gui02
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui02 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui02_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Img = localOpenPic(varargin)% ��ť�Ļص��������������û�ѡ��ͼ���ļ����򿪲���ʾ
% ͼ���ļ����ͣ�������������ʾ����
filter = { ...
'*.bmp;*.jpg;*.gif;*.emf', '����ͼ���ļ� (*.bmp; *.jpg; *.gif; *emf)'; ...
'*.bmp', 'λͼ�ļ� (*.bmp)'; ...
'*.jpg', 'JPEG�ļ� (*.jpg)'; ...
'*.gif', 'GIF�ļ� (*.gif)'; ...
'*.emf', 'ͼԪ�ļ� (*.emf)'; ...
'*.*', '�����ļ� (*.*)' ...
};
% ѡ���ļ�
[filename, pathname] = uigetfile( filter, '��...');
if isequal(filename,0) || isequal(pathname,0)
    return, 
end
% ����ͼ����ʾ
[Img, map] = imread([pathname filename]);
colormap(map)
if size(Img,3)==3
    Img = rgb2gray(Img);
end
image(Img)
% ��������ϵΪ�ʺ���ʾͼ��ķ�ʽ
axis image
set(gca, 'vis', 'off')

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Img = localOpenPic;
global Img;
%figure;
%imshow(Img);title('img original');
set(handles.edit1,'string','ͼ��ѡ��ɹ�')




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'string','');
set(handles.edit1,'string','��ȴ�������')
global Img;
global M;
global M_enc;
M = uint8(Img);
M_enc = ImageDecryption(M,"kali");
cla(handles.axes1);
image(M_enc)
% ��������ϵΪ�ʺ���ʾͼ��ķ�ʽ
axis image
set(gca, 'vis', 'off')
warndlg('Ĭ�ϼ�����ԿΪ��kali.', '��ʾ');%���ݣ�����
%figure;
%imshow(M_enc);title('img enc');
set(handles.edit1,'string','');
set(handles.edit1,'string','ͼ����ܳɹ�')


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'string','');
set(handles.edit1,'string','��ȴ�������')
global M;
global M_enc;
global M_hide;
global T1;
global T2;
global BoDongJuZhen;
Mgray = bitand(M,240);
data = uint8('designed by caoyakun bjdzkjxy   ');
data = de2bi(data,8);
data = reshape(data,[1, size(data,1)*8]);
[T1,T2,BoDongJuZhen] = StandardCalculation(Mgray,data);
kh = "hide";
M_hide = DataEmbedding(data, M_enc, kh, T1, T2, BoDongJuZhen);
cla(handles.axes1);
image(M_hide)
% ��������ϵΪ�ʺ���ʾͼ��ķ�ʽ
axis image
set(gca, 'vis', 'off')
nextmsg = '    Ĭ������������ԿΪ��hide.';
outputstring = sprintf(['Ĭ�ϼ�����ϢΪ��designed by caoyakun bjdzkjxy \n' ...
                '"%s"'],nextmsg);
title = '��ʾ��Ϣ';
h=msgbox(outputstring,title);
%warndlg('Ĭ������������ԿΪ��hide./n Ĭ�ϼ�����ϢΪ��designed by caoyakun bjdzkjxy', '��ʾ');%���ݣ�����
%figure;
%imshow(M_hide);title('img hide');
set(handles.edit1,'string','');
set(handles.edit1,'string','��������Ƕ��ɹ�')



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'string','');
set(handles.edit1,'string','��ȴ�������')
global M_hide;
global M_dec;
M_dec = ImageDecryption(M_hide, "kali");
cla(handles.axes1);
image(M_dec)
% ��������ϵΪ�ʺ���ʾͼ��ķ�ʽ
axis image
set(gca, 'vis', 'off')
%figure;
%imshow(M_dec);title('img dec');
set(handles.edit1,'string','');
set(handles.edit1,'string','ͼ���ѽ���')


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'string','');
set(handles.edit1,'string','��ȴ�������')
global T1;
global T2;
global BoDongJuZhen;
global M_dec;
kh = "hide";
[M_src, secret] = DataExtraction(M_dec,kh,256,T1, T2, BoDongJuZhen);
cla(handles.axes1);
image(M_src)
% ��������ϵΪ�ʺ���ʾͼ��ķ�ʽ
axis image
set(gca, 'vis', 'off')
%figure;
%imshow(M_src);title('img src');
secret1 = reshape(secret,[32 8]);
secret2 = bi2de(secret1);
secret3 = char(secret2)';
set(handles.edit1,'string','');
str=strcat('ͼ���ѻָ���������ϢΪ��',secret3);
set(handles.edit1,'String',str);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
button=questdlg('��лʹ�ñ���Ʒ�������ȷ���˳���','�˳����','��','��','��'); %���ݣ����⣬ѡ�Ĭ��ѡ��
if strcmp(button,'��')
      delete(hObject);
end
