function varargout = ramcustprofs(varargin)
% RAMCUSTPROFS MATLAB code for ramcustprofs.fig
%      RAMCUSTPROFS, by itself, creates a new RAMCUSTPROFS or raises the existing
%      singleton*.
%
%      H = RAMCUSTPROFS returns the handle to a new RAMCUSTPROFS or the handle to
%      the existing singleton*.
%
%      RAMCUSTPROFS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RAMCUSTPROFS.M with the given input arguments.
%
%      RAMCUSTPROFS('Property','Value',...) creates a new RAMCUSTPROFS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ramcustprofs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ramcustprofs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ramcustprofs

% Last Modified by GUIDE v2.5 29-Jun-2016 14:44:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ramcustprofs_OpeningFcn, ...
                   'gui_OutputFcn',  @ramcustprofs_OutputFcn, ...
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


% --- Executes just before ramcustprofs is made visible.
function ramcustprofs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ramcustprofs (see VARARGIN)

% Choose default command line output for ramcustprofs
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ramcustprofs wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global definedenv
global signalsources
global surfobject
global Lat
global Lon
global H
global profmatrix
Lat=surfobject.XData(1,:);
Lon=surfobject.YData(:,1);
H=surfobject.ZData;
if exist('definedenv')==1;
    if length(definedenv)==length(signalsources)
        [~, indx1]=min(abs(Lat-(definedenv(1).coords(1))));
        [~, indx2]=min(abs(Lat-(definedenv(1).coords(2))));
        [~, indy1]=min(abs(Lon-(definedenv(1).coords(3))));
        [~, indy2]=min(abs(Lon-(definedenv(1).coords(4))));
        H=surfobject.ZData(min(indx1,indx2):max(indx1,indx2),min(indy1,indy2):max(indy1,indy2));
        Lat=Lat(min(indx1,indx2):max(indx1,indx2));
        Lon=Lon(min(indy1,indy2):max(indy1,indy2));
        hsize=size(H);
        hl1=hsize(1);
        hl2=hsize(2);
        v_lat=linspace(min(Lat),max(Lat),hl1);
        v_lon=linspace(min(Lon),max(Lon),hl2);
        [Lonplot,Latplot]=meshgrid(v_lon,v_lat);
        %plot
        h=gca;
        ph=pcolor(h,Latplot,Lonplot,H);
        set(ph,'edgecolor','none');
        xlabel(sprintf('Latitude%c', char(176)));ylabel(sprintf('Longitude%c', char(176)));
        %set(h,'xticklabel',sprintf('%.1d',Lat));
        %set(h,'yticklabel',sprintf('%.1d',Lon));
        shading interp;
        caxis([min(min(H)) max(max(H))]);
        colormap('default');
        h = colorbar;
        h2 = get(h, 'ylabel');
        set(h2, 'string', 'Depth (m)');
        hold on
        plot(str2double(signalsources(get(handles.source_select,'value')).latitude),str2double(signalsources(get(handles.source_select,'value')).longitude),'k^')
        hold off
    else
        h=gca;
        ph=pcolor(h,surfobject.XData,surfobject.YData,surfobject.ZData);
        set(ph,'edgecolor','none');
        xlabel(sprintf('Latitude%c', char(176)));ylabel(sprintf('Longitude%c', char(176)));
        shading interp;
        caxis([min(min(surfobject.ZData)) max(max(surfobject.ZData))]);
        colormap('default');
        h = colorbar;
        h2 = get(h, 'ylabel');
        set(h2, 'string', 'Depth (m)');
        hold on
        plot(str2double(signalsources(get(handles.source_select,'value')).latitude),str2double(signalsources(get(handles.source_select,'value')).longitude),'k^')
        hold off
    end
    for i=1:length(signalsources)
       if i==1; s=char(signalsources(i).sourcelabel); else
           s=char(char(s), signalsources(i).sourcelabel);
       end
    end
    set(handles.source_select,'string',s);
end
for i=1:length(signalsources)
   profmatrix(i).sourcelabel=signalsources(i).sourcelabel; 
end
% if ~isempty(profmatrix(get(handles.source_select,'value')).coordsmatrix)
%     hold on
%     for i=1:length(profmatrix(get(handles.source_select,'value')).coordsmatrix)
%        plot([str2double(signalsources(get(handles.source_select,'value')).latitude) profmatrix(get(handles.source_select,'value')).coordsmatrix(i,1)],...
%            [str2double(signalsources(get(handles.source_select,'value')).longitude) profmatrix(get(handles.source_select,'value')).coordsmatrix(i,2)],'r')
%     end
% end
% set(handles.uitable1,'data',profmatrix(get(handles.source_select,'value')).coordsmatrix);


% --- Outputs from this function are returned to the command line.
function varargout = ramcustprofs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global definedenv
global profarray
global signalsources
global profmatrix
env=definedenv(get(handles.source_select,'value'));
source=signalsources(get(handles.source_select,'value'));
uiwait(ramcustprof_latlonentry(env,source))
hold on
for i=1:length(profarray)
   plot([str2double(signalsources(get(handles.source_select,'value')).latitude) profarray(i,1)],...
       [str2double(signalsources(get(handles.source_select,'value')).longitude) profarray(i,2)],'r') 
end
data=get(handles.uitable1,'data');
set(handles.uitable1,'data',[data ; profarray]);
profmatrix(get(handles.source_select,'value')).coordsmatrix=[data; profarray];

%populate table with profiles
%append profarray to array for source

% --- Executes on button press in take.
function take_Callback(hObject, eventdata, handles)
% hObject    handle to take (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%delete selcted profile
global userselect
global profmatrix
data=get(handles.uitable1,'data');
data(userselect(:,1),:)=[];
set(handles.uitable1,'data',data);
profmatrix(get(handles.source_select,'value')).coordsmatrix=data;


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


% --- Executes on selection change in source_select.
function source_select_Callback(hObject, eventdata, handles)
% hObject    handle to source_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns source_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from source_select
global definedenv
global surfobject
global signalsources
global Lat
global Lon
global H
global profmatrix
Lat=surfobject.XData(1,:);
Lon=surfobject.YData(:,1);
H=surfobject.ZData;
if ~isempty(definedenv(get(handles.source_select,'value')).coords)
    [~, indx1]=min(abs(Lat-(definedenv(get(handles.source_select,'value')).coords(1))));
    [~, indx2]=min(abs(Lat-(definedenv(get(handles.source_select,'value')).coords(2))));
    [~, indy1]=min(abs(Lon-(definedenv(get(handles.source_select,'value')).coords(3))));
    [~, indy2]=min(abs(Lon-(definedenv(get(handles.source_select,'value')).coords(4))));
    H=surfobject.ZData(min(indx1,indx2):max(indx1,indx2),min(indy1,indy2):max(indy1,indy2));
    Lat=Lat(min(indx1,indx2):max(indx1,indx2));
    Lon=Lon(min(indy1,indy2):max(indy1,indy2));
    hsize=size(H);
    hl1=hsize(1);
    hl2=hsize(2);
    v_lat=linspace(min(Lat),max(Lat),hl1);
    v_lon=linspace(min(Lon),max(Lon),hl2);
    [Lonplot,Latplot]=meshgrid(v_lon,v_lat);
    %plot
    h=gca;
    ph=pcolor(h,Latplot,Lonplot,H);
    set(ph,'edgecolor','none');
    xlabel(sprintf('Latitude%c', char(176)));ylabel(sprintf('Longitude%c', char(176)));
    shading interp;
    caxis([min(min(H)) max(max(H))]);
    colormap('default');
    h = colorbar;
    h2 = get(h, 'ylabel');
    set(h2, 'string', 'Depth (m)');
    hold on
    plot(str2double(signalsources(get(handles.source_select,'value')).latitude),str2double(signalsources(get(handles.source_select,'value')).longitude),'k^')
    hold off
else
    h=gca;
    ph=pcolor(h,surfobject.XData,surfobject.YData,surfobject.ZData);
    set(ph,'edgecolor','none');
    xlabel(sprintf('Latitude%c', char(176)));ylabel(sprintf('Longitude%c', char(176)));
    shading interp;
    caxis([min(min(surfobject.ZData)) max(max(surfobject.ZData))]);
    colormap('default');
    h = colorbar;
    h2 = get(h, 'ylabel');
    set(h2, 'string', 'Depth (m)');
    hold on
    plot(str2double(signalsources(get(handles.source_select,'value')).latitude),str2double(signalsources(get(handles.source_select,'value')).longitude),'k^')
    hold off
end
if ~isempty(profmatrix(get(handles.source_select,'value')).coordsmatrix)
    hold on
    for i=1:length(profmatrix(get(handles.source_select,'value')).coordsmatrix)
       plot([str2double(signalsources(get(handles.source_select,'value')).latitude) profmatrix(get(handles.source_select,'value')).coordsmatrix(i,1)],...
           [str2double(signalsources(get(handles.source_select,'value')).longitude) profmatrix(get(handles.source_select,'value')).coordsmatrix(i,2)],'r')
    end
end
set(handles.uitable1,'data',profmatrix(get(handles.source_select,'value')).coordsmatrix);

% --- Executes during object creation, after setting all properties.
function source_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to source_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% run RAM for selected profiles

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% save profiles to file?


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global userselect
userselect=eventdata.Indices;
