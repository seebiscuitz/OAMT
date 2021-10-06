function varargout = sourcesedit(varargin)
% SOURCESEDIT MATLAB code for sourcesedit.fig
%      SOURCESEDIT, by itself, creates a new SOURCESEDIT or raises the existing
%      singleton*.
%
%      H = SOURCESEDIT returns the handle to a new SOURCESEDIT or the handle to
%      the existing singleton*.
%
%      SOURCESEDIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOURCESEDIT.M with the given input arguments.
%
%      SOURCESEDIT('Property','Value',...) creates a new SOURCESEDIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sourcesedit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sourcesedit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sourcesedit

% Last Modified by GUIDE v2.5 28-Jun-2016 13:10:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sourcesedit_OpeningFcn, ...
                   'gui_OutputFcn',  @sourcesedit_OutputFcn, ...
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
% 18/12/2015    release: sourceseditv0
%   Initial version
%--------------------------------------------------------------------------


% --- Executes just before sourcesedit is made visible.
function sourcesedit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sourcesedit (see VARARGIN)

% Choose default command line output for sourcesedit
handles.output = hObject;

% - global variables -
global sourcecounter
global signalsources
%load object array
%signalsources=getappdata(oamtv2_6,'signalsources');
if isempty(signalsources)
    signalsources=sourceclass;
    sourcecounter=1;
else
    %load into dropdown etc.
    signalsourcessize=length(signalsources);
    newlist=cell(signalsourcessize,1);
    for i=1:signalsourcessize
        newlist{i}=signalsources(i).sourcelabel;
    end
    sourcecounter=signalsourcessize+1;
    set(handles.sourcelist,'string',newlist')
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sourcesedit wait for user response (see UIRESUME)
% uiwait(handles.sourcesedit);


% --- Outputs from this function are returned to the command line.
function varargout = sourcesedit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in sourcelist.
function sourcelist_Callback(hObject, eventdata, handles)
% hObject    handle to sourcelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% - global variables -
global signalsources
% - end -
currsource=get(handles.sourcelist,'value');
set(handles.sourcename,'string',signalsources(currsource).sourcelabel);
set(handles.sourcelat,'string',signalsources(currsource).latitude);
set(handles.sourcelon,'string',signalsources(currsource).longitude);
set(handles.sourcefrequency,'string',signalsources(currsource).frequencyvector);
set(handles.sourcefrequency,'string',signalsources(currsource).sourcelevel);
set(handles.sourcedepth,'string',signalsources(currsource).depth);
% Hints: contents = cellstr(get(hObject,'String')) returns sourcelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sourcelist


% --- Executes during object creation, after setting all properties.
function sourcelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sourcelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addnewsource.
function addnewsource_Callback(hObject, eventdata, handles)
% hObject    handle to addnewsource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% - global variables -
global sourcecounter
global signalsources
% - end -
old_list = get(handles.sourcelist,'string');
signalsources(sourcecounter)=sourceclass;
signalsources(sourcecounter).sourcelabel=['Source' num2str(sourcecounter)];
if isempty(old_list)
    newlist=signalsources(sourcecounter).sourcelabel;
else
    newlist=char(char(old_list),signalsources(sourcecounter).sourcelabel);
end
% clear other handles
set(handles.sourcelist,'string',newlist,'value',size(newlist,1));
set(handles.sourcename,'string',signalsources(sourcecounter).sourcelabel);
set(handles.sourcelat,'string','0')
set(handles.sourcelon,'string','0')
set(handles.sourcefrequency,'string','')
set(handles.sourcelevel,'string','')
set(handles.sourcedepth,'string','0')
sourcecounter=sourcecounter+1;
% disp(sourcecounter)

% --- Executes on button press in deletecurrsource.
function deletecurrsource_Callback(hObject, eventdata, handles)
% hObject    handle to deletecurrsource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% - global variables -
global signalsources
global sourcecounter
% - end -
currsource=get(handles.sourcelist,'value');
signalsources(currsource)=[];
newlist=get(handles.sourcelist,'string');
newlist(currsource,:)=[];
set(handles.sourcelist,'string',newlist,'value',currsource);
sourcecounter=sourcecounter-1;
sourcecounter(sourcecounter<0)=0;


function sourcename_Callback(hObject, eventdata, handles)
% hObject    handle to sourcename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sourcename as text
%        str2double(get(hObject,'String')) returns contents of sourcename as a double


% --- Executes during object creation, after setting all properties.
function sourcename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sourcename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveandclose.
function saveandclose_Callback(hObject, eventdata, handles)
% hObject    handle to saveandclose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% - global variables - 
global signalsources
global filepath
global gsession_name
% - end -
setappdata(oamtv2_6,'signalsources',signalsources)
%create log of sources and save them to file
createlogsource(filepath,gsession_name,signalsources);
uiresume(oamtv2_6)
delete(sourcesedit)

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(sourcesedit)

function sourcelat_Callback(hObject, eventdata, handles)
% hObject    handle to sourcelat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sourcelat as text
%        str2double(get(hObject,'String')) returns contents of sourcelat as a double


% --- Executes during object creation, after setting all properties.
function sourcelat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sourcelat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sourcelon_Callback(hObject, eventdata, handles)
% hObject    handle to sourcelon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sourcelon as text
%        str2double(get(hObject,'String')) returns contents of sourcelon as a double


% --- Executes during object creation, after setting all properties.
function sourcelon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sourcelon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sourcefrequency_Callback(hObject, eventdata, handles)
% hObject    handle to sourcefrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sourcefrequency as text
%        str2double(get(hObject,'String')) returns contents of sourcefrequency as a double


% --- Executes during object creation, after setting all properties.
function sourcefrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sourcefrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in svecurrsource.
function svecurrsource_Callback(hObject, eventdata, handles)
% hObject    handle to svecurrsource (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% - global variables -
global signalsources
global xq yq
global surfobject
% - end -
% - check source is within boundary
xv=[xq.xcord xq.xcord+xq.diff xq.xcord+xq.diff xq.xcord xq.xcord];
yv=[yq.ycord yq.ycord yq.ycord+yq.diff yq.ycord+yq.diff yq.ycord];
if inpolygon(str2double(get(handles.sourcelat,'string')),str2double(get(handles.sourcelon,'string')),xv,yv);
    % - within bathymetry area -
        % - check depth/retrieve depth at source -
        [~, idx]=min(abs(surfobject.XData(1,:)-str2double(get(handles.sourcelat,'string'))));
        [~, idy]=min(abs(surfobject.YData(:,1)-str2double(get(handles.sourcelon,'string'))));
        if abs(surfobject.ZData(idx,idy))>abs(str2double(get(handles.sourcedepth,'string')))
            % - save source -
            currsource=get(handles.sourcelist,'value');
            signalsources(currsource).sourcelabel=get(handles.sourcename,'string');
            signalsources(currsource).latitude=get(handles.sourcelat,'string');
            signalsources(currsource).longitude=get(handles.sourcelon,'string');
            signalsources(currsource).frequencyvector=get(handles.sourcefrequency,'string');
            signalsources(currsource).sourcelevel=get(handles.sourcelevel,'string');
            signalsources(currsource).depth=get(handles.sourcedepth,'string');            
            % - end -
            % - update list -
            currlist=cellstr(get(handles.sourcelist,'string'));
            currlist{currsource}=signalsources(currsource).sourcelabel;
            set(handles.sourcelist,'string',currlist,'value',currsource);
            % - end -
        else
            % - display depth warning -
            msgbox('Source depth is larger than the depth for the entered latitude and longitude, please enter another depth', 'Error','error');
            % - end -
        end
        % - end -
    % - end -
else
    % - display lat and lon warning -
    msgbox('The entered latitude and longitude for this source is outside the designated bathymetry region, please enter another value', 'Error','error');
    % - end -
end
% - end -



function sourcedepth_Callback(hObject, eventdata, handles)
% hObject    handle to sourcedepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sourcedepth as text
%        str2double(get(hObject,'String')) returns contents of sourcedepth as a double


% --- Executes during object creation, after setting all properties.
function sourcedepth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sourcedepth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sourcelevel_Callback(hObject, eventdata, handles)
% hObject    handle to sourcelevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sourcelevel as text
%        str2double(get(hObject,'String')) returns contents of sourcelevel as a double


% --- Executes during object creation, after setting all properties.
function sourcelevel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sourcelevel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
