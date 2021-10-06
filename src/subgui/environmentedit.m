function varargout = environmentedit(varargin)
% ENVIRONMENTEDIT MATLAB code for environmentedit.fig
%      ENVIRONMENTEDIT, by itself, creates a new ENVIRONMENTEDIT or raises the existing
%      singleton*.
%
%      H = ENVIRONMENTEDIT returns the handle to a new ENVIRONMENTEDIT or the handle to
%      the existing singleton*.
%
%      ENVIRONMENTEDIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENVIRONMENTEDIT.M with the given input arguments.
%
%      ENVIRONMENTEDIT('Property','Value',...) creates a new ENVIRONMENTEDIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before environmentedit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to environmentedit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help environmentedit

% Last Modified by GUIDE v2.5 08-Jun-2016 13:02:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @environmentedit_OpeningFcn, ...
                   'gui_OutputFcn',  @environmentedit_OutputFcn, ...
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


% --- Executes just before environmentedit is made visible.
function environmentedit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to environmentedit (see VARARGIN)

% Choose default command line output for environmentedit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes environmentedit wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% load envclass data into text fields %
global envclass
if isempty(envclass); 
    envclass=environmentclass; 
else
    %load envdata
end
set(handles.dz,'string',envclass.dz);
set(handles.dr,'string',envclass.dr);
set(handles.cw,'string',envclass.cw);
set(handles.cs,'string',envclass.cs);
set(handles.rho,'string',envclass.rho);
set(handles.attn,'string',envclass.attn);
set(handles.ws,'string',envclass.ws);



% --- Outputs from this function are returned to the command line.
function varargout = environmentedit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filepath
fileID=fopen([filepath 'data\env.dat'],'w');
fprintf(fileID,'dz=%s \r\n',get(handles.dz,'string'));
fprintf(fileID,'dr=%s \r\n',get(handles.dr,'string'));
fprintf(fileID,'cw=%s \r\n',get(handles.cw,'string'));
fprintf(fileID,'cs=%s \r\n',get(handles.cs,'string'));
fprintf(fileID,'rho=%s \r\n',get(handles.rho,'string'));
fprintf(fileID,'attn=%s \r\n',get(handles.attn,'string'));
fprintf(fileID,'ws=%s \r\n',get(handles.ws,'string'));
fclose(fileID);
delete(environmentedit);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global envclass
dz=get(handles.dz,'string');
dr=get(handles.dr,'string');
cw=get(handles.cw,'string');
cs=get(handles.cs,'string');
rho=get(handles.rho,'string');
attn=get(handles.attn,'string');
ws=get(handles.ws,'string');
envclass=environmentclass(dz,dr,cw,cs,rho,attn,ws);
uiresume(oamtv2_6);
delete(environmentedit);

function dz_Callback(hObject, eventdata, handles)
% hObject    handle to dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dz as text
%        str2double(get(hObject,'String')) returns contents of dz as a double


% --- Executes during object creation, after setting all properties.
function dz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dr_Callback(hObject, eventdata, handles)
% hObject    handle to dr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dr as text
%        str2double(get(hObject,'String')) returns contents of dr as a double


% --- Executes during object creation, after setting all properties.
function dr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cw_Callback(hObject, eventdata, handles)
% hObject    handle to cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cw as text
%        str2double(get(hObject,'String')) returns contents of cw as a double


% --- Executes during object creation, after setting all properties.
function cw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cs_Callback(hObject, eventdata, handles)
% hObject    handle to cs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cs as text
%        str2double(get(hObject,'String')) returns contents of cs as a double


% --- Executes during object creation, after setting all properties.
function cs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rho_Callback(hObject, eventdata, handles)
% hObject    handle to rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rho as text
%        str2double(get(hObject,'String')) returns contents of rho as a double


% --- Executes during object creation, after setting all properties.
function rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function attn_Callback(hObject, eventdata, handles)
% hObject    handle to attn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of attn as text
%        str2double(get(hObject,'String')) returns contents of attn as a double


% --- Executes during object creation, after setting all properties.
function attn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to attn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ws_Callback(hObject, eventdata, handles)
% hObject    handle to ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ws as text
%        str2double(get(hObject,'String')) returns contents of ws as a double


% --- Executes during object creation, after setting all properties.
function ws_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ws (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function load_from_file_Callback(hObject, eventdata, handles)
% hObject    handle to load_from_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global envclass
[filename,pathname]=uigetfile({'*.dat','DATA File (.dat)';'*.*','All Files (*.*)'},'Open File',cd);
envfile=dir(fullfile(pathname,filename));
envclass=loadenvclass(envfile);

% --------------------------------------------------------------------
function save_to_file_Callback(hObject, eventdata, handles)
% hObject    handle to save_to_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filepath
fileID=fopen([filepath 'data\env.dat'],'w');
fprintf(fileID,'dz=%s \r\n',get(handles.dz,'string'));
fprintf(fileID,'dr=%s \r\n',get(handles.dr,'string'));
fprintf(fileID,'cw=%s \r\n',get(handles.cw,'string'));
fprintf(fileID,'cs=%s \r\n',get(handles.cs,'string'));
fprintf(fileID,'rho=%s \r\n',get(handles.rho,'string'));
fprintf(fileID,'attn=%s \r\n',get(handles.attn,'string'));
fprintf(fileID,'ws=%s \r\n',get(handles.ws,'string'));
fclose(fileID);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
