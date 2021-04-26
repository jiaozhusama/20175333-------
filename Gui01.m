function varargout = Gui01(varargin)
% GUI01 MATLAB code for Gui01.fig
%      GUI01, by itself, creates a new GUI01 or raises the existing
%      singleton*.
%
%      H = GUI01 returns the handle to a new GUI01 or the handle to
%      the existing singleton*.
%
%      GUI01('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI01.M with the given input arguments.
%
%      GUI01('Property','Value',...) creates a new GUI01 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Gui01_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Gui01_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Gui01

% Last Modified by GUIDE v2.5 22-Apr-2021 22:10:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Gui01_OpeningFcn, ...
                   'gui_OutputFcn',  @Gui01_OutputFcn, ...
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


% --- Executes just before Gui01 is made visible.
function Gui01_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Gui01 (see VARARGIN)

% Choose default command line output for Gui01
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Gui01 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Gui01_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Gui02;
pause(2);
close(Gui01);