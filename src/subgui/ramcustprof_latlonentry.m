function varargout = ramcustprof_latlonentry(varargin)
% RAMCUSTPROF_LATLONENTRY MATLAB code for ramcustprof_latlonentry.fig
%      RAMCUSTPROF_LATLONENTRY, by itself, creates a new RAMCUSTPROF_LATLONENTRY or raises the existing
%      singleton*.
%
%      H = RAMCUSTPROF_LATLONENTRY returns the handle to a new RAMCUSTPROF_LATLONENTRY or the handle to
%      the existing singleton*.
%
%      RAMCUSTPROF_LATLONENTRY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RAMCUSTPROF_LATLONENTRY.M with the given input arguments.
%
%      RAMCUSTPROF_LATLONENTRY('Property','Value',...) creates a new RAMCUSTPROF_LATLONENTRY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ramcustprof_latlonentry_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ramcustprof_latlonentry_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ramcustprof_latlonentry

% Last Modified by GUIDE v2.5 22-Jun-2016 15:22:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ramcustprof_latlonentry_OpeningFcn, ...
                   'gui_OutputFcn',  @ramcustprof_latlonentry_OutputFcn, ...
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


% --- Executes just before ramcustprof_latlonentry is made visible.
function ramcustprof_latlonentry_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ramcustprof_latlonentry (see VARARGIN)

% Choose default command line output for ramcustprof_latlonentry
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global env
global source
env=varargin{1};
source=varargin{2};

% UIWAIT makes ramcustprof_latlonentry wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ramcustprof_latlonentry_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function xlat1_Callback(hObject, eventdata, handles)
% hObject    handle to xlat1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xlat1 as text
%        str2double(get(hObject,'String')) returns contents of xlat1 as a double


% --- Executes during object creation, after setting all properties.
function xlat1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlat1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xlat2_Callback(hObject, eventdata, handles)
% hObject    handle to xlat2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xlat2 as text
%        str2double(get(hObject,'String')) returns contents of xlat2 as a double


% --- Executes during object creation, after setting all properties.
function xlat2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlat2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xlon1_Callback(hObject, eventdata, handles)
% hObject    handle to xlon1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xlon1 as text
%        str2double(get(hObject,'String')) returns contents of xlon1 as a double


% --- Executes during object creation, after setting all properties.
function xlon1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlon1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xlon2_Callback(hObject, eventdata, handles)
% hObject    handle to xlon2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xlon2 as text
%        str2double(get(hObject,'String')) returns contents of xlon2 as a double


% --- Executes during object creation, after setting all properties.
function xlon2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xlon2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function noprof_Callback(hObject, eventdata, handles)
% hObject    handle to noprof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noprof as text
%        str2double(get(hObject,'String')) returns contents of noprof as a double


% --- Executes during object creation, after setting all properties.
function noprof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noprof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global env
global profarray
global source
% generate profile class with data
xlat1=str2double(get(handles.xlat1,'string'));
xlat2=str2double(get(handles.xlat2,'string'));
xlon1=str2double(get(handles.xlon1,'string'));
xlon2=str2double(get(handles.xlon2,'string'));
mxlt=max(env.coords(1),env.coords(2));
mnlt=min(env.coords(1),env.coords(2));
mxln=max(env.coords(3),env.coords(4));
mnln=min(env.coords(3),env.coords(4));
if isempty(get(handles.xlat2,'string')) || isempty(get(handles.xlon2,'string')) || isempty(get(handles.noprof,'string'))
    profarray=zeros(1,2);
    profarray(1,1)=xlat1;
    profarray(1,2)=xlon1;
else
    np=str2double(get(handles.noprof,'string'));    
    profarray=zeros(np+1,2);
    n=0:np;
    steplat=(xlat2-xlat1)/np;
    steplon=(xlon2-xlon1)/np;
    profarray(n+1,1)=xlat1+n.*steplat;
    profarray(n+1,2)=xlon1+n.*steplon;
    profarray(profarray(:,1)>mxlt,1)=mxlt;
    profarray(profarray(:,1)<mnlt,1)=mnlt;
    profarray(profarray(:,2)>mxln,2)=mxln;
    profarray(profarray(:,2)<mnln,2)=mnln;
    for i=2:length(profarray)-1
       m=(str2double(source.longitude)-profarray(i,2))/(str2double(source.latitude)-profarray(i,1)); 
       c=str2double(source.longitude)-m*str2double(source.latitude);
       if m>0
          x=(mxln-c)/m;
          profarray(i,1)=x;
          profarray(i,2)=mxln;
       end
       if m<0
           x=(mnln-c)/m;
           profarray(i,1)=x;
           profarray(i,2)=mnln;
       end
       if x>mxlt; y=m*mxlt+c; 
          profarray(i,1)=mxlt;
          profarray(i,2)=y;
       end
       if x<mnlt; y=m*mnlt+c; 
          profarray(i,1)=mnlt;
          profarray(i,2)=y;
       end    
    end
end
delete(gcf)
uiresume(ramcustprofs)
    
% if xlat2/xlon2 or noprof empty gen 1 profile of xlat1 xlon1

% save profile class
