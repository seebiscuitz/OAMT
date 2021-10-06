function varargout = newsession(varargin)
% NEWSESSION MATLAB code for newsession.fig
%      NEWSESSION, by itself, creates a new NEWSESSION or raises the existing
%      singleton*.
%
%      H = NEWSESSION returns the handle to a new NEWSESSION or the handle to
%      the existing singleton*.
%
%      NEWSESSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWSESSION.M with the given input arguments.
%
%      NEWSESSION('Property','Value',...) creates a new NEWSESSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newsession_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newsession_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newsession

% Last Modified by GUIDE v2.5 22-Mar-2016 11:58:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newsession_OpeningFcn, ...
                   'gui_OutputFcn',  @newsession_OutputFcn, ...
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

%--------------------------------------------------------------------------
%                               CHANGELOG
%
% 24/04/2016 release: newsession
%1. Initial release of code
%--------------------------------------------------------------------------


% --- Executes just before newsession is made visible.
function newsession_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newsession (see VARARGIN)

% Choose default command line output for newsession
handles.output = hObject;
global filepath
propmodels=dir([filepath '/src/functions/models']);
if isempty(propmodels)
    set(handles.activemodel,'string','(no models found)')
else
    s='';
    for i=1:length(propmodels)
       name=propmodels(i).name;
       if ~(name(1)=='.'); s=[cellstr(s);cellstr(propmodels(i).name)]; end
    end
    set(handles.activemodel,'string',s)
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes newsession wait for user response (see UIRESUME)
% uiwait(handles.newsession);


% --- Outputs from this function are returned to the command line.
function varargout = newsession_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in create_session.
function create_session_Callback(hObject, eventdata, handles)
% hObject    handle to create_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% create or overwrite file with current settings
%save preferences to file
global gsession_name
global currsesspref
gsession_name=get(handles.session_name,'string');
currsesspref.scalefactor=get(handles.scalefactor,'string');
interpmethod=cellstr(get(handles.interpmethod,'string'));
currsesspref.interpmethod=interpmethod{get(handles.interpmethod,'value')};
currsesspref.envresolution=get(handles.resolution,'string');
activemodel=cellstr(get(handles.activemodel,'string'));
currsesspref.propagationmodel=activemodel{get(handles.activemodel,'value')};
close(newsession)

% --- Executes on button press in cancel_preferences.
function cancel_preferences_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_preferences (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(newsession)

% --- Executes on selection change in interpmethodbox.
function interpmethodbox_Callback(hObject, eventdata, handles)
% hObject    handle to interpmethodbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns interpmethodbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from interpmethodbox


% --- Executes during object creation, after setting all properties.
function interpmethodbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interpmethodbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sessionprefix_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to sessionprefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sessionprefix as text
%        str2double(get(hObject,'String')) returns contents of sessionprefix as a double


% --- Executes during object creation, after setting all properties.
function sessionprefix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sessionprefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scalefactorbox_Callback(hObject, eventdata, handles)
% hObject    handle to scalefactorbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scalefactorbox as text
%        str2double(get(hObject,'String')) returns contents of scalefactorbox as a double


% --- Executes during object creation, after setting all properties.
function scalefactorbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scalefactorbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bathyresolution_Callback(hObject, eventdata, handles)
% hObject    handle to bathyresolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bathyresolution as text
%        str2double(get(hObject,'String')) returns contents of bathyresolution as a double


% --- Executes during object creation, after setting all properties.
function bathyresolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bathyresolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in activemodel.
function activemodel_Callback(hObject, eventdata, handles)
% hObject    handle to activemodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns activemodel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from activemodel


% --- Executes during object creation, after setting all properties.
function activemodel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to activemodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function session_name_Callback(hObject, eventdata, handles)
% hObject    handle to session_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of session_name as text
%        str2double(get(hObject,'String')) returns contents of session_name as a double


% --- Executes during object creation, after setting all properties.
function session_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to session_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scalefactor_Callback(hObject, eventdata, handles)
% hObject    handle to scalefactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scalefactor as text
%        str2double(get(hObject,'String')) returns contents of scalefactor as a double


% --- Executes during object creation, after setting all properties.
function scalefactor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scalefactor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in interpmethod.
function interpmethod_Callback(hObject, eventdata, handles)
% hObject    handle to interpmethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns interpmethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from interpmethod


% --- Executes during object creation, after setting all properties.
function interpmethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interpmethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function resolution_Callback(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of resolution as text
%        str2double(get(hObject,'String')) returns contents of resolution as a double


% --- Executes during object creation, after setting all properties.
function resolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in activemodel.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to activemodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns activemodel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from activemodel


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to activemodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close settingsedit.
function settingsedit_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to settingsedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
