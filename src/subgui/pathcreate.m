function varargout = pathcreate(varargin)
% PATHCREATE MATLAB code for pathcreate.fig
%      PATHCREATE, by itself, creates a new PATHCREATE or raises the existing
%      singleton*.
%
%      H = PATHCREATE returns the handle to a new PATHCREATE or the handle to
%      the existing singleton*.
%
%      PATHCREATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PATHCREATE.M with the given input arguments.
%
%      PATHCREATE('Property','Value',...) creates a new PATHCREATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pathcreate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pathcreate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pathcreate

% Last Modified by GUIDE v2.5 26-Apr-2016 18:11:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pathcreate_OpeningFcn, ...
                   'gui_OutputFcn',  @pathcreate_OutputFcn, ...
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


% --- Executes just before pathcreate is made visible.
function pathcreate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pathcreate (see VARARGIN)

% Choose default command line output for pathcreate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pathcreate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pathcreate_OutputFcn(hObject, eventdata, handles) 
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
global total_time
global step_num
global starting_coordinate
global source_level
total_time=str2double(get(handles.total_time,'string'));
step_num=str2double(get(handles.step_num,'string'));
starting_coordinate.x=str2double(get(handles.starting_latitude,'string'));
starting_coordinate.y=str2double(get(handles.starting_longitude,'string'));
source_level=str2double(get(handles.source_level,'string'));
close(pathcreate)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(pathcreate)


function starting_latitude_Callback(hObject, eventdata, handles)
% hObject    handle to starting_latitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of starting_latitude as text
%        str2double(get(hObject,'String')) returns contents of starting_latitude as a double


% --- Executes during object creation, after setting all properties.
function starting_latitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to starting_latitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function starting_longitude_Callback(hObject, eventdata, handles)
% hObject    handle to starting_longitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of starting_longitude as text
%        str2double(get(hObject,'String')) returns contents of starting_longitude as a double


% --- Executes during object creation, after setting all properties.
function starting_longitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to starting_longitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function step_num_Callback(hObject, eventdata, handles)
% hObject    handle to step_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of step_num as text
%        str2double(get(hObject,'String')) returns contents of step_num as a double


% --- Executes during object creation, after setting all properties.
function step_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function total_time_Callback(hObject, eventdata, handles)
% hObject    handle to total_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_time as text
%        str2double(get(hObject,'String')) returns contents of total_time as a double


% --- Executes during object creation, after setting all properties.
function total_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function source_level_Callback(hObject, eventdata, handles)
% hObject    handle to source_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of source_level as text
%        str2double(get(hObject,'String')) returns contents of source_level as a double


% --- Executes during object creation, after setting all properties.
function source_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to source_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
