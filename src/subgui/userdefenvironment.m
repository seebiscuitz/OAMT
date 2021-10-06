function varargout = userdefenvironment(varargin)
% USERDEFENVIRONMENT MATLAB code for userdefenvironment.fig
%      USERDEFENVIRONMENT, by itself, creates a new USERDEFENVIRONMENT or raises the existing
%      singleton*.
%
%      H = USERDEFENVIRONMENT returns the handle to a new USERDEFENVIRONMENT or the handle to
%      the existing singleton*.
%
%      USERDEFENVIRONMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USERDEFENVIRONMENT.M with the given input arguments.
%
%      USERDEFENVIRONMENT('Property','Value',...) creates a new USERDEFENVIRONMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before userdefenvironment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to userdefenvironment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help userdefenvironment

% Last Modified by GUIDE v2.5 21-Jun-2016 16:19:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @userdefenvironment_OpeningFcn, ...
                   'gui_OutputFcn',  @userdefenvironment_OutputFcn, ...
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


% --- Executes just before userdefenvironment is made visible.
function userdefenvironment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to userdefenvironment (see VARARGIN)

% Choose default command line output for userdefenvironment
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes userdefenvironment wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global surfobject
global signalsources
global definedenv
global rxslist
ph=pcolor(surfobject.XData,surfobject.YData,surfobject.ZData);
set(ph,'edgecolor','none');
xlabel(sprintf('Latitude%c', char(176)));ylabel(sprintf('Longitude%c', char(176)));
shading interp;
caxis([min(min(surfobject.ZData)) max(max(surfobject.ZData))]);
colormap('default');
h = colorbar;
h2 = get(h, 'ylabel');
set(h2, 'string', 'Depth (m)');
hold on
if isempty(definedenv)
    for i=1:length(signalsources)
        if i==1; definedenv=userdeclass; else definedenv(i)=userdeclass; end
        plot(str2double(str2double(signalsources(i).latitude),signalsources(i).longitude),'k^');
        if i==1;
              s=char(signalsources(i).sourcelabel); 
        else
              s=char(char(s), signalsources(i).sourcelabel); 
        end
    end
else
    for i=1:length(signalsources)
        plot(str2double(signalsources(i).latitude),str2double(signalsources(i).longitude),'k^');
        text(str2double(signalsources(i).latitude),str2double(signalsources(i).longitude),...
            1,signalsources(i).sourcelabel);
        if i==1;
              s=char(signalsources(i).sourcelabel); 
        else
              s=char(char(s), signalsources(i).sourcelabel); 
        end
        try
            try
                a=strsplit(definedenv(i).coords,' ');
                xlat1=str2double(a(1));
                xlat2=str2double(a(2));
                xlon1=str2double(a(3));
                xlon2=str2double(a(4));
            catch 
                xlat1=definedenv(i).coords(1);
                xlat2=definedenv(i).coords(2);
                xlon1=definedenv(i).coords(3);
                xlon2=definedenv(i).coords(4);
            end
            rectangle('Position',[min(xlat1,xlat2) min(xlon1,xlon2) max(xlat1,xlat2)-min(xlat1,xlat2) max(xlon1,xlon2)-min(xlon1,xlon2)],'EdgeColor','r',...
            'LineWidth',2);
            rxslist(i)=i;
        catch
        end
    end
    try
        set(handles.xlat1,'string',num2str(definedenv(1).coords(1)));
        set(handles.xlat2,'string',num2str(definedenv(1).coords(2)));
        set(handles.xlon1,'string',num2str(definedenv(1).coords(3)));
        set(handles.xlon2,'string',num2str(definedenv(1).coords(4)));
        set(handles.cas_check,'value',definedenv(1).cas);
        set(handles.range,'string',...
        sprintf('%.2fx%.2f',definedenv(get(handles.source_select,'value')).xrange*10^-3,...
            definedenv(get(handles.source_select,'value')).yrange*10^-3));
    catch
    end
end
rxslist=fliplr(rxslist);
set(handles.source_select,'string',s);
grid on
hold off


% --- Outputs from this function are returned to the command line.
function varargout = userdefenvironment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in source_select.
function source_select_Callback(hObject, eventdata, handles)
% hObject    handle to source_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns source_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from source_select
global definedenv
global signalsources
% h=findobj(gca,'type','line');
% delete(h);
% for i=1:length(signalsources);
%     if i==get(handles.source_select,'value')
%         plot(str2double(signalsources(i).latitude),str2double(signalsources(i).longitude),'b^');
%     else
%         plot(str2double(signalsources(i).latitude),str2double(signalsources(i).longitude),'k^');
%     end
% end
%try 
    if strcmp(class(definedenv(get(handles.source_select,'value')).coords),'char')
            coordstring=strsplit(definedenv(get(handles.source_select,'value')).coords,' ');
            coordstring=str2double(coordstring);
            definedenv(get(handles.source_select,'value')).coords=coordstring;
    end
    set(handles.xlat1,'string',num2str(definedenv(get(handles.source_select,'value')).coords(1)));
    set(handles.xlat2,'string',num2str(definedenv(get(handles.source_select,'value')).coords(2)));
    set(handles.xlon1,'string',num2str(definedenv(get(handles.source_select,'value')).coords(3)));
    set(handles.xlon2,'string',num2str(definedenv(get(handles.source_select,'value')).coords(4)));
    set(handles.cas_check,'value',definedenv(get(handles.source_select,'value')).cas);
    set(handles.range,'string','');
    set(handles.range,'string',...
        sprintf('%.2fx%.2f',definedenv(get(handles.source_select,'value')).xrange*10^-3,...
        definedenv(get(handles.source_select,'value')).yrange*10^-3));
%catch
%    set(handles.xlat1,'string','');
%    set(handles.xlat2,'string','');
%    set(handles.xlon1,'string','');
%    set(handles.xlon2,'string','');
%    set(handles.cas_check,'value',0);
%    set(handles.range,'string','');
%end

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


% --- Executes on button press in save_close.
function save_close_Callback(hObject, eventdata, handles)
% hObject    handle to save_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global definedenv
global signalsources
if get(handles.all_sources,'value')==1
    xlat1=str2double(get(handles.xlat1,'string'));
    xlon1=str2double(get(handles.xlon1,'string'));
    xlat2=str2double(get(handles.xlat2,'string'));
    xlon2=str2double(get(handles.xlon2,'string'));
    xrange=vdist(xlat1,xlon1,xlat2,xlon1);
    yrange=vdist(xlat1,xlon1,xlat1,xlon2);
    for i=1:length(definedenv)
        definedenv(i)=userdeclass(signalsources(i).sourcelabel,get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);
    end
    uiresume(oamtv2_6);
    delete(userdefenvironment);
else
    uiresume(oamtv2_6);
    delete(userdefenvironment);
end
    
    


% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(userdefenvironment);

% --- Executes on button press in cas_check.
function cas_check_Callback(hObject, eventdata, handles)
% hObject    handle to cas_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cas_check
set(handles.range,'string','');
set(handles.xlat1,'enable','off');
set(handles.xlon1,'enable','off');
set(handles.xlat2,'enable','off');
set(handles.xlon2,'enable','off');


function range_Callback(hObject, eventdata, handles)
% hObject    handle to range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of range as text
%        str2double(get(hObject,'String')) returns contents of range as a double
global definedenv
global signalsources
global rxslist
global surfobject
mxlt=max(surfobject.XData(1,:));
mnlt=min(surfobject.XData(1,:));
mxln=max(surfobject.YData(:,1));
mnln=min(surfobject.YData(:,1));
if get(handles.cas_check,'value')==1
    sourcelat=str2double(signalsources(get(handles.source_select,'value')).latitude);
    sourcelon=str2double(signalsources(get(handles.source_select,'value')).longitude);
    dr=str2double(get(handles.range,'string'));
    drlat=dr/110.574; drlon=dr/(111.320*cosd(sourcelat+drlat));
    lat1=sourcelat+drlat;
    lat2=sourcelat-drlat;
    lon1=sourcelon-drlon;
    lon2=sourcelon+drlon;
    if sourcelat+drlat>mxlt; lat1=mxlt; end
    if sourcelat-drlat<mnlt; lat2=mnlt; end
    if sourcelon-drlon<mnln; lon1=mnln; end
    if sourcelon+drlon>mxln; lon2=mxln; end
    set(handles.xlat1,'string',num2str(lat1));
    set(handles.xlon1,'string',num2str(lon1));
    set(handles.xlat2,'string',num2str(lat2));
    set(handles.xlon2,'string',num2str(lon2));
    xlat1=str2double(get(handles.xlat1,'string'));
    xlon1=str2double(get(handles.xlon1,'string'));
    xlat2=str2double(get(handles.xlat2,'string'));
    xlon2=str2double(get(handles.xlon2,'string'));
    xrange=vdist(xlat1,xlon1,xlat2,xlon1);
    yrange=vdist(xlat1,xlon1,xlat1,xlon2);
    if isempty(definedenv); definedenv=userdeclass; end
    definedenv(get(handles.source_select,'value'))=userdeclass(...
        signalsources(get(handles.source_select,'value')).sourcelabel,...
        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);
    try
        h=findobj(gca,'type','rectangle');
        indx=find(rxslist==get(handles.source_select,'value'));
        delete(h(indx));
        rxslist(indx)=[];
    catch
    end
    rectangle('Position',[min(xlat1,xlat2) min(xlon1,xlon2) max(xlat1,xlat2)-min(xlat1,xlat2) max(xlon1,xlon2)-min(xlon1,xlon2)],'EdgeColor','r',...
        'LineWidth',2);
    rxslist=[get(handles.source_select,'value') rxslist];
end

% --- Executes during object creation, after setting all properties.
function range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to range (see GCBO)
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
global definedenv
global singalsources
xlat1=str2double(get(handles.xlat1,'string'));
xlon1=str2double(get(handles.xlon1,'string'));
xlat2=str2double(get(handles.xlat2,'string'));
xlon2=str2double(get(handles.xlon2,'string'));
xrange='';
yrange='';
if ~isempty(xlat1)
    if ~isempty(xlon1)
        if ~isempty(xlat2)
            if ~isempty(xlon2)
                xrange=vdist(xlat1,xlon1,xlat2,xlon1);
                yrange=vdist(xlat1,xlon1,xlat1,xlon2);
                definedenv(get(handles.source_select,'value'))=userdeclass(...
                    singalsources(get(handles.source_select,'value')).sourcelabel,...
                        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);
                filename=sprintf('%s_env.dat',signalsources(get(handles.source_select,'value')).sourcelabel);
                fileID=fopen([filepath 'data\' filename],'w');
                fprintf(fileID,'sourcelabel=%s \r\n',singalsources(get(handles.source_select,'value')).sourcelabel);
                fprintf(fileID,'cas=%s \r\n',num2str(get(handles.cas_check,'value')));
                fprintf(fileID,'xrange=%s \r\n',xrange);
                fprintf(fileID,'yrange=%s \r\n',yrange);
                fprintf(fileID,'coords=%s %s %s %s \r\n',num2str(xlat1),num2str(xlat1),num2str(xlon1),num2str(xlon2));
                fclose(fileID);
            end
        end
    end
end
definedenv(get(handles.source_select,'value'))=userdeclass(...
    singalsources(get(handles.source_select,'value')).sourcelabel,...
        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);

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
global definedenv
global singalsources
xlat1=str2double(get(handles.xlat1,'string'));
xlon1=str2double(get(handles.xlon1,'string'));
xlat2=str2double(get(handles.xlat2,'string'));
xlon2=str2double(get(handles.xlon2,'string'));
xrange='';
yrange='';
if ~isempty(xlat1)
    if ~isempty(xlon1)
        if ~isempty(xlat2)
            if ~isempty(xlon2)
                xrange=vdist(xlat1,xlon1,xlat2,xlon1);
                yrange=vdist(xlat1,xlon1,xlat1,xlon2);
                definedenv(get(handles.source_select,'value'))=userdeclass(...
                    singalsources(get(handles.source_select,'value')).sourcelabel,...
                        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);
                filename=sprintf('%s_env.dat',signalsources(get(handles.source_select,'value')).sourcelabel);
                fileID=fopen([filepath 'data\' filename],'w');
                fprintf(fileID,'sourcelabel=%s \r\n',singalsources(get(handles.source_select,'value')).sourcelabel);
                fprintf(fileID,'cas=%s \r\n',num2str(get(handles.cas_check,'value')));
                fprintf(fileID,'xrange=%s \r\n',xrange);
                fprintf(fileID,'yrange=%s \r\n',yrange);
                fprintf(fileID,'coords=%s %s %s %s \r\n',num2str(xlat1),num2str(xlat1),num2str(xlon1),num2str(xlon2));
                fclose(fileID);            
            end
        end
    end
end
definedenv(get(handles.source_select,'value'))=userdeclass(...
    singalsources(get(handles.source_select,'value')).sourcelabel,...
        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);

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
global definedenv
global singalsources
xlat1=str2double(get(handles.xlat1,'string'));
xlon1=str2double(get(handles.xlon1,'string'));
xlat2=str2double(get(handles.xlat2,'string'));
xlon2=str2double(get(handles.xlon2,'string'));
xrange='';
yrange='';
if ~isempty(xlat1)
    if ~isempty(xlon1)
        if ~isempty(xlat2)
            if ~isempty(xlon2)
                xrange=vdist(xlat1,xlon1,xlat2,xlon1);
                yrange=vdist(xlat1,xlon1,xlat1,xlon2);
                definedenv(get(handles.source_select,'value'))=userdeclass(...
                    singalsources(get(handles.source_select,'value')).sourcelabel,...
                        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);
                filename=sprintf('%s_env.dat',signalsources(get(handles.source_select,'value')).sourcelabel);
                fileID=fopen([filepath 'data\' filename],'w');
                fprintf(fileID,'sourcelabel=%s \r\n',singalsources(get(handles.source_select,'value')).sourcelabel);
                fprintf(fileID,'cas=%s \r\n',num2str(get(handles.cas_check,'value')));
                fprintf(fileID,'xrange=%s \r\n',xrange);
                fprintf(fileID,'yrange=%s \r\n',yrange);
                fprintf(fileID,'coords=%s %s %s %s \r\n',num2str(xlat1),num2str(xlat1),num2str(xlon1),num2str(xlon2));
                fclose(fileID);
            end
        end
    end
end
definedenv(get(handles.source_select,'value'))=userdeclass(...
    singalsources(get(handles.source_select,'value')).sourcelabel,...
        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);

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
global definedenv
global singalsources
xlat1=str2double(get(handles.xlat1,'string'));
xlon1=str2double(get(handles.xlon1,'string'));
xlat2=str2double(get(handles.xlat2,'string'));
xlon2=str2double(get(handles.xlon2,'string'));
xrange='';
yrange='';
if ~isempty(xlat1)
    if ~isempty(xlon1)
        if ~isempty(xlat2)
            if ~isempty(xlon2)
                xrange=vdist(xlat1,xlon1,xlat2,xlon1);
                yrange=vdist(xlat1,xlon1,xlat1,xlon2);
                definedenv(get(handles.source_select,'value'))=userdeclass(...
                    singalsources(get(handles.source_select,'value')).sourcelabel,...
                        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);
                filename=sprintf('%s_env.dat',signalsources(get(handles.source_select,'value')).sourcelabel);
                fileID=fopen([filepath 'data\' filename],'w');
                fprintf(fileID,'sourcelabel=%s \r\n',singalsources(get(handles.source_select,'value')).sourcelabel);
                fprintf(fileID,'cas=%s \r\n',num2str(get(handles.cas_check,'value')));
                fprintf(fileID,'xrange=%s \r\n',xrange);
                fprintf(fileID,'yrange=%s \r\n',yrange);
                fprintf(fileID,'coords=%s %s %s %s \r\n',num2str(xlat1),num2str(xlat1),num2str(xlon1),num2str(xlon2));
                fclose(fileID);
            end
        end
    end
end
definedenv(get(handles.source_select,'value'))=userdeclass(...
    singalsources(get(handles.source_select,'value')).sourcelabel,...
        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]);

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


% --- Executes on button press in all_sources.
function all_sources_Callback(hObject, eventdata, handles)
% hObject    handle to all_sources (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of all_sources
global definedenv
if get(handles.all_sources,'value')==1
    set(handles.source_select,'enable','off');
    set(handles.cas_check,'value',0);
    set(handles.cas_check,'enable','off');
else
    set(handles.source_select,'enable','on');
    set(handles.cas_check,'enable','on');
    set(handles.cas_check,'value',definedenv(get(handles.source_select,'value')).cas);
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
global surfobject
global rxslist
global definedenv
global signalsources
global filepath
if get(handles.checkbox3,'value')==1
    set(handles.xlat1,'enable','off')
    set(handles.xlat2,'enable','off')
    set(handles.xlon1,'enable','off')
    set(handles.xlon2,'enable','off')
    set(handles.xlat1,'string',num2str(min(surfobject.XData(1,:))));
    set(handles.xlat2,'string',num2str(max(surfobject.XData(1,:))));
    set(handles.xlon1,'string',num2str(min(surfobject.YData(:,1))));
    set(handles.xlon2,'string',num2str(max(surfobject.YData(:,1))));
    xlat1=str2double(get(handles.xlat1,'string'));
    xlon1=str2double(get(handles.xlon1,'string'));
    xlat2=str2double(get(handles.xlat2,'string'));
    xlon2=str2double(get(handles.xlon2,'string'));
    xrange=vdist(xlat1,xlon1,xlat2,xlon1);
    yrange=vdist(xlat1,xlon1,xlat1,xlon2);
    rectangle('Position',[min(xlat1,xlat2) min(xlon1,xlon2) max(xlat1,xlat2)-min(xlat1,xlat2) max(xlon1,xlon2)-min(xlon1,xlon2)],'EdgeColor','r',...
        'LineWidth',2);
    definedenv(get(handles.source_select,'value'))=userdeclass(...
        signalsources(get(handles.source_select,'value')).sourcelabel,...
        get(handles.cas_check,'value'),xrange,yrange,[xlat1 xlon1;xlat2 xlon2]); 
    filename=sprintf('%s_env.dat',signalsources(get(handles.source_select,'value')).sourcelabel);
    fileID=fopen([filepath 'data\' filename],'w');
    fprintf(fileID,'sourcelabel=%s \r\n',signalsources(get(handles.source_select,'value')).sourcelabel);
    fprintf(fileID,'cas=%s \r\n',num2str(get(handles.cas_check,'value')));
    fprintf(fileID,'xrange=%s \r\n',xrange);
    fprintf(fileID,'yrange=%s \r\n',yrange);
    fprintf(fileID,'coords=%s %s %s %s \r\n',num2str(xlat1),num2str(xlat1),num2str(xlon1),num2str(xlon2));
    fclose(fileID);
else
    set(handles.xlat1,'enable','on')
    set(handles.xlat2,'enable','on')
    set(handles.xlon1,'enable','on')
    set(handles.xlon2,'enable','on')
end