function varargout = settingseditv1(varargin)
% SETTINGSEDITV1 MATLAB code for settingseditv1.fig
%      SETTINGSEDITV1, by itself, creates a new SETTINGSEDITV1 or raises the existing
%      singleton*.
%
%      H = SETTINGSEDITV1 returns the handle to a new SETTINGSEDITV1 or the handle to
%      the existing singleton*.
%
%      SETTINGSEDITV1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SETTINGSEDITV1.M with the given input arguments.
%
%      SETTINGSEDITV1('Property','Value',...) creates a new SETTINGSEDITV1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before settingseditv1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to settingseditv1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help settingseditv1

% Last Modified by GUIDE v2.5 14-Mar-2016 12:16:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @settingseditv1_OpeningFcn, ...
                   'gui_OutputFcn',  @settingseditv1_OutputFcn, ...
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
% 18/12/2015    release: settingsseditv0
%   Initial version
% 29/02/2015    release: settingsseditv1
%   Changed default session prefix to bathymetry resolution. Default
%   session prefix no longer a changeable option.
%
%--------------------------------------------------------------------------


% --- Executes just before settingseditv1 is made visible.
function settingseditv1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to settingseditv1 (see VARARGIN)

% Choose default command line output for settingseditv1
handles.output = hObject;
% update inputs from current settings
global currsesspref
propmodels=dir([cd '/src/functions/models']);
if isempty(propmodels)
    set(handles.activemodel,'string','(no models found)')
else
    s='';
    for i=1:length(propmodels)
       name=propmodels(i).name;
       if ~(name(1)=='.'); s=[cellstr(s);cellstr(propmodels(i).name)]; end
    end
    set(handles.activemodel,'string',s)
    try
        set(handles.activemodel,'value',find(strcmp(cellstr(get(handles.activemodel,'string')),cellstr(currsesspref.propagationmodel))))
    catch
    end
end
set(handles.scalefactorbox,'string',currsesspref.scalefactor)
set(handles.interpmethodbox,'value',find(strcmp(cellstr(get(handles.interpmethodbox,'string')),currsesspref.interpmethod)))
set(handles.envsres,'string',currsesspref.envresolution)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes settingseditv1 wait for user response (see UIRESUME)
% uiwait(handles.settingseditv1);


% --- Outputs from this function are returned to the command line.
function varargout = settingseditv1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in save_preferences.
function save_preferences_Callback(hObject, eventdata, handles)
% hObject    handle to save_preferences (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% create or overwrite file with current settings
global currsesspref
global filepath
currsesspref.scalefactor=get(handles.scalefactorbox,'string');
interpmethodboxstring=cellstr(get(handles.interpmethodbox,'string'));
currsesspref.interpmethod=interpmethodboxstring{get(handles.interpmethodbox,'value')};
currsesspref.envresolution=get(handles.envsres,'string');
activemodelboxstring=cellstr(get(handles.activemodel,'string'));
currsesspref.propagationmodel=activemodelboxstring{get(handles.activemodel,'value')};
%save preferences to file
createpreferencesfile(currsesspref,filepath);
close(settingseditv1)

% --- Executes on button press in cancel_preferences.
function cancel_preferences_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_preferences (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(settingseditv1)

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



function sessionprefix_Callback(hObject, eventdata, handles)
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



function envsres_Callback(hObject, eventdata, handles)
% hObject    handle to envsres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of envsres as text
%        str2double(get(hObject,'String')) returns contents of envsres as a double


% --- Executes during object creation, after setting all properties.
function envsres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to envsres (see GCBO)
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
