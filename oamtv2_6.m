function varargout = oamtv2_6(varargin)
% oamtv2_6 MATLAB code for oamtv2_6.fig
%      oamtv2_6, by itself, creates a new oamtv2_6 or raises the existing
%      singleton*.
%
%      H = oamtv2_6 returns the handle to a new oamtv2_6 or the handle to
%      the existing singleton*.
%
%      oamtv2_6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in oamtv2_6.M with the given input arguments.
%
%      oamtv2_6('Property','Value',...) creates a new oamtv2_6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before oamtv2_6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to oamtv2_6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help oamtv2_6

% Last Modified by GUIDE v2.5 13-Jun-2016 14:27:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @oamtv2_6_OpeningFcn, ...
                   'gui_OutputFcn',  @oamtv2_6_OutputFcn, ...
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

%------------------------------------------------------------------------------------------------------------------------------------------------------------------
%           CHANGELOG
%
% 24/04/2016   release: oamtv2_6
%1. Modified GUI to provide more information regarding each stage and minor modifications to layout.
% 20/04/2016   release: oamtv2_6
%1. Implemented Range-dependent Acoustic Model(RAM) into system through MATLAB code from oalib.hlsresearch.com
%2. Modified tlpanel to include data controls to plot and select TL profiles created by RAM.
%3. Added plotRAM function to plot environment and initial transect on tlpanel axes.
%4. Modified local functions; open_session, runpropagationmodel_Callback, source_select to accomodate for RAM. External functions; runpropmodels modified aswell.
%5. Addition of new functions; tl_goforward, tl_goback, view_tl_profile for RAM specific case.
% 14/03/2016   release: oamtv2_5
%1. Added new session gui allowing user to set session name and settings on start.
%2. Implemented propagation models into system, based on folders in ...//src/functions/models/.
% 26/01/2016    release: oamtv2_4
%1. moved plotting of surface to seperate function.
%2. minor formating changes to code layout inc. indenting and commening sections.
%3. user can now resume a previously created session from file.
% 12/01/2016    release: oamtv2_3
%1. updated new_session to clear previous data.
%2. changed session file structure and general structure of folder.
%3. removed global save_state variable and removed save_session from GUI.
% 12/01/2016    release: oamtv2_2
%1. added log creation and resume file for opening session
% 29/12/2015    release: oamtv2_1
%1. changed new session and opening function to accomodate for uiwait in creating sources.
%2. implemetned bathymetry export to jpg.
% 18/12/2015    release: oamtv1
%1. implemented preferences into system, allows user to save preferences to file, preferences loaded from settings.txt on startup. Opens from settingsedit.fig file.
%2. added source entry figure to system, opens from sourcesedit.fig in subfigures folder. Creates an array of sources from class of type sourceclass.
% 08/12/2015    release: oamt
%1. removed sources and environment tabs and sources ui panel from GUI.
%2. added menu to gui for file, options and help
% 30/11/2015    release: oamt
%1. added rottate buton to environemtn panel to allow map rotation.
%2. created seconddary surf plot of scaled down data to increase speeed of rotation, can still refer to surfobject for generating 2d maps for RAM.
% 28/11/2015    release: oamt
%1. added panels to define each piece of information required into sections inc. environment, source and sound exposure.
%2. changed sources tab axes locations so labels are visible.
%3. added information to environment panel attributing to data size in each dimension and time taken to complete process.
% 24/11/2015    release: oamt
%1. pushbutton1_Callback now checks selected file_menu type before calling loadbathymetry function.
%2. loadbathymetry changed to individual .m's for each suported filetype.
%3. uigetfile call extended to include supported file_menu types and starts at a default location
%4. small changes to oamtv2_6.fig
%5. fixed .nc file_menu readin errors. Also allows files with multiple periods to be used as long as the file_menu extension matches the supported types.
%--------------------------------------------------------------------------------------------------------------------------------------------------------------------

% --- Executes just before oamtv2_6 is made visible.
function oamtv2_6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to oamtv2_6 (see VARARGIN)
% Choose default command line output for oamtv2_6
handles.output = hObject;
% Update handles structure
% set(handles.axes1,'xtick',[],'ytick',[])
guidata(hObject, handles);
if isempty(strfind(path,[pwd '\src;']))
        addpath(genpath(pwd))
end 
c=imread('tool_rotate_3d.png');
c=im2double(c);
c2=imread('zoom.png');
c2=im2double(c2);
set(handles.togglebutton1,'cdata',c)
set(handles.togglebutton2,'cdata',c)
set(handles.togglebutton3,'cdata',c2)
movegui(gcf,'center')
% UIWAIT makes oamtv2_6 wait for user response (see UIRESUME)
% uiwait(handles.oamtv2_6);


% --- Outputs from this function are returned to the command line.
function varargout = oamtv2_6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function inputloc_Callback(hObject, eventdata, handles)
% hObject    handle to inputloc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputloc as text
%        str2double(get(hObject,'String')) returns contents of inputloc as a double


% --- Executes during object creation, after setting all properties.
function inputloc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputloc (see GCBO)
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
global latitude
global longitude
global elevation
global gsession_name
global filepath
[filename,pathname]=uigetfile({'*.nc','GEBCO Data (*.nc)';...
    '*.csv','CSV (comma delimeted) (*.csv)';...
    '*.mat;*','MATLAB Files(*.mat)';...
    '*.*','All Files (*.*)'},'Open File...',...
    cd);
if length(filename)==1 || length(pathname)==1;else 
set(handles.inputloc,'ForegroundColor',[0 0 0],'string',[pathname filename]);end
%determine filetype
fileidx=strfind(filename,'.');
if isempty(fileidx);else
    filetype=filename(fileidx(end):end);
    switch filetype
        case '.nc'
            %NC Format
            [latitude,longitude,elevation]=loadnc(pathname,filename);
            datasizes=[size(latitude);size(longitude);size(elevation)];
            set(handles.create_surface,'Enable','on')
            set(handles.edit_environment,'Enable','on')
            set(handles.status_text,'string','')
            createlogbathyreadin(filepath,gsession_name,pathname,filename,filetype,datasizes);
        case '.csv'
            %CSV Format
            [latitude,longitude,elevation]=loadcsv(pathname,filename);
            datasizes=[size(latitude);size(longitude);size(elevation)];
            set(handles.create_surface,'Enable','on')
            set(handles.edit_environment,'Enable','on')
            set(handles.status_text,'string','')
            createlogbathyreadin(filepath,gsession_name,pathname,filename,filetype,datasizes);
            %create log
        case '.mat'
            %MATLAB Workspace
            [latitude,longitude,elevation]=loadmat(pathname,filename);
            datasizes=[size(latitude);size(longitude);size(elevation)];
            set(handles.create_surface,'Enable','on')
            set(handles.edit_environment,'Enable','on')
            set(handles.status_text,'string','')
            createlogbathyreadin(filepath,gsession_name,pathname,filename,filetype,datasizes);
            %create log
        otherwise
            %Non-supported file_menu types
            set(handles.status_text,'ForegroundColor',[1 0 0],'FontAngle','italic','string',['Unsupported filetype: ' filetype])
            set(handles.inputloc,'ForegroundColor',[1 0 0])
            %create log
    end
    set(handles.edit_environment,'enable','on');
end    
% end
%

function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to butbathtosurf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in create_surface.
function create_surface_Callback(hObject, eventdata, handles)
% hObject    handle to create_surface (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global latitude
global longitude
global elevation
global currsesspref
global filepath
global gsession_name
global surfobject
global xq yq
% - create surface
    waithandle=waitbar(0,'Creating Surface...','Name','Please wait...');
    axes(handles.axes1)
    cla(handles.axes1)
    tic;
    surfobject = bathtosurf1(latitude,longitude,elevation,currsesspref.interpmethod,currsesspref.envresolution);
    elpt = toc;
% - end -
    waitbar(0.25,waithandle,'Scaling object for display...');
% - scale to size -
    decimatestep=round(100/str2double(currsesspref.scalefactor));
    [plotdata, xq, yq]=decimateplot(surfobject,decimatestep);
    waitbar(0.5,waithandle,'Plotting to axis...');
    plotsurface(plotdata,xq,yq);
    figure(waithandle);
    waitbar(0.80,waithandle,'Creating log...');
    createlogsurface(filepath,gsession_name,surfobject);
% - end -
% - set text handles -
    set(handles.environment_data,'string',{sprintf('Created environment in %.2f seconds from data of size (%dm): ',elpt,str2num(currsesspref.envresolution));...
        sprintf('      X Data: %d -> %d elements',numel(latitude),length(surfobject.XData));sprintf('      Y Data: %d -> %d elements',numel(longitude),length(surfobject.YData));...
        sprintf('      Z Data: %d -> %d elements',numel(elevation),numel(surfobject.ZData))});
    set(handles.scalenote,'string',['Note: Environment is presented at ' currsesspref.scalefactor '% scale factor.']);
    set(handles.pushbutton6,'Enable','on')
    set(handles.create_source,'Enable','on')
    set(handles.bathy_export,'Enable','on')
    delete(waithandle)
% - end -


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text7.
function text7_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Environment


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text8.
function text8_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Sources


% --- Executes on button press in create_sources.
function create_sources_Callback(hObject, eventdata, handles)
% hObject    handle to create_sources (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signalsources
[filename,pathname]=uigetfile({'*.dat','DATA File (*.dat)'},'Open File...',...
    cd);
if length(filename)==1 || length(pathname)==1;else 
set(handles.edit3,'string',[pathname filename]);end
%determine filetype
filetype=filename(strfind(filename,'.'):end);
%check supported filetype
if isempty(filetype)
    %no filetype
else
    %set vars
    signalsources=loadsources(filepath);
    source_filename = filename;
    source_pathname = pathname;
    set(handles.create_sources,'Enable','on');
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in create_source.
function create_source_Callback(hObject, eventdata, handles)
% hObject    handle to create_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% - global variables -
global signalsources
uiwait(sourcesedit)
if not(isempty(signalsources))
    %plot onto bathymetry
    if strcmp(get(handles.bathypanel,'visible'),'off')
        set(handles.tlpanel,'visible','off');
        set(handles.bathypanel,'visible','on');
    end
    axes(handles.axes1);
    h=findobj('type','line');
    if ~isempty(h)
        delete(h)
    end
    hold on
    for i=1:length(signalsources)
        plot3(str2double(signalsources(i).latitude),str2double(signalsources(i).longitude),-1*str2double(signalsources(i).depth),'k^');
    end
    grid on
    hold off
    set(handles.runpropagationmodel,'Enable','on');
    set(handles.source_export,'Enable','on')
else
    set(handles.sourceerror,'string','!Error: No sources found');
end

% --- Executes on button press in runpropagationmodel.
function runpropagationmodel_Callback(hObject, eventdata, handles)
% hObject    handle to runpropagationmodel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% - global variables -
global surfobject
global currsesspref
global signalsources
global TL
global TLtransectNo
global coordsmatrix
global filepath definedenv
% - end -
% - run models -
[TL, returncode, coordsmatrix]= runpropmodels(currsesspref, surfobject, signalsources);
% - end -
% - plot data -
switch returncode
    case 'EnergyFlux'
        for i=1:length(signalsources)
            if i==1; s=char(signalsources(1).sourcelabel); else
                s=char(char(s), signalsources(i).sourcelabel);
            end
        end
        s2=char(strsplit(signalsources(1).frequencyvector));
        set(handles.source_select,'string',s)
        set(handles.frequency_select,'string',s2)
        plotEFlux(handles,TL(1).tlarray(1).tlvector,surfobject,signalsources(1),definedenv(1));
        set(findall(handles.uipanel9, '-property', 'Enable'), 'Enable', 'off');
    case 'RAM'
        for i=1:length(signalsources)
            if i==1; s=char(signalsources(1).sourcelabel); else
                s=char(char(s), signalsources(i).sourcelabel);
            end
        end
        s2=char(strsplit(signalsources(1).frequencyvector));
        set(handles.source_select,'string',s)
        set(handles.frequency_select,'string',s2)
        plotRAM(handles, signalsources, surfobject);
        save([filepath '/data/RAM/coordsmatrix.mat'],'coordsmatrix');
        TLtransectNo=1;
        % - set controls -
        set(handles.tl_goforward,'Enable','on');
        set(handles.tl_back,'Enable','on');
    otherwise
end
% - end -
% - end -

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in create_path.
function create_path_Callback(hObject, eventdata, handles)
% hObject    handle to create_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TL
global filepath
global TLtransectNo
global coordsmatrix
global signalsources
global surfobject
uiwait(pathcreate)
% - map TL profiles to grid -
%create bearing matrix
global total_time
global step_num
global starting_coordinate
global source_level
if ~isempty(total_time) && ~isempty(step_num) && ~isempty(starting_coordinate) && ~isemtpy(source_level)
    cartgrid=[];
    bearingmatrix=zeros(length(coordsmatrix),2);
    for i=1:length(signalsources)
        SrcLat=str2double(signalsources(i).latitude);
        SrcLon=str2double(signalsources(i).longitude);
        for j=1:length(coordsmatrix)
            delX=SrcLat-coordsmatrix(j,1);
            delY=SrcLon-coordsmatrix(j,2);
            bearingmatrix(j,i)=tand(delX/delY);
        end
        % - create cartesian grid -
        cartgrid=[cartgrid; calccartgrid(TL,SrcLat,SrcLon,bearingmatrix(:,i))];
        % - end -
    end
    cartgrid=sortrows(cartgrid,[1,-2]);
    v_x=linspace(min(cartgrid(:,1)),max(cartgrid(:,1)));
    v_y=linspace(min(cartgrid(:,2)),max(cartgrid(:,2)));
    [xq,yq]=meshgrid(v_x,v_y);
    cartgrid=griddata(cartgrid(:,1),cartgrid(:,2),cartgrid(:,3),xq,yq);
    % - create path -
    lat=surfobject.XData(1,:);
    lon=surfobject.YData(:,1);
    range_grid.x1=min(lat); range_grid.x2=max(lat);
    range_grid.y1=min(lon); range_grid.y2=max(lon);
    [x,y,time]=walk2drand(starting_coordinate,step_num,range_grid,total_time);
    % - end -
    % - calculate cumulative sound exposure -
    cumsndexp=zeros(length(x),2);
    cumsndexp(:,1)=time;
    for i=1:length(x)
        [~,idx]=min(abs(v_x-x(i)));
        [~,idy]=min(abs(v_y-y(i)));
        if i==1; cumsndexp(i,2)=cartgrid(idx,idy); 
        else
            cumsndexp(i,2)=cumsndexp(i-1,2)+cartgrid(idx,idy); 
        end
    end
    cumsndexp=cumsndexp+source_level;
    % - end -
    % - plot to axes -
    h=figure('Name','Cumulative Sound Exposure for Random Walk (%d steps)');
    plot(cumsndexp,'b','LineWidth',2)
    xlabel('Time (s)')
    ylabel('Sound Exposure (dB)')
    title('Cumulative Sound Exposure Over Time')
    % - end -
end
    
% --- Executes on button press in edit_path.
function edit_path_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    set(rotate3d,'Enable','on')
else
    set(rotate3d,'Enable','off')
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --------------------------------------------------------------------
function file_menu_Callback(hObject, eventdata, handles)
% hObject    handle to file_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function new_session_Callback(hObject, eventdata, handles)
% hObject    handle to new_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% clears data and makes new session
% global vars
global gsession_name
global currsesspref
global filepath
global signalsources
% set session name and save_state
% open new_session figure for data input
filepath=cd;
oldgsession_name=gsession_name;
uiwait(newsession)
if ~(strcmp(oldgsession_name,gsession_name))
    % clear data
    cla(handles.axes1,'reset')
    set(handles.axes1,'xtick',[],'ytick',[])
    currsesspref=settingsclass;
    signalsources=sourceclass;
    set(handles.inputloc,'string','navigate to file/folder location...')
    set(handles.edit3,'string','navigate to file/folder location...')
    set(handles.environment_data,'string','No bathymetry data selected');
    set(handles.scalenote,'string',' ');
    [~, session_started]=gensessname(currsesspref.defaultsessionprefix);
    try
        mkdir('session',gsession_name);
        filepath=[cd '\session\' gsession_name];
        createpreferencesfile(currsesspref, filepath);
        set(handles.session_started,'string',['Session Started: ' session_started])
        set(handles.session_name,'string',['Session Name: ' gsession_name]);
        createlog(gsession_name,session_started,filepath);
        createresume(gsession_name,filepath);
        set(handles.create_source,'Enable','off');
        set(handles.pushbutton6,'Enable','off');
        set(handles.pushbutton1,'Enable','on');
        msgbox(sprintf('Sucessfully created new session: %s',gsession_name),'Session Created');
    catch
    end
end



% --------------------------------------------------------------------
function save_session_Callback(hObject, eventdata, handles)
% hObject    handle to save_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function open_session_Callback(hObject, eventdata, handles)
% hObject    handle to open_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%load object
%- globals -
global currsesspref surfobject filepath gsession_name xq yq signalsources
global TL TLtransectNo envclass
%- end -
% - set global variables -
%if ~(pathname==0)
    %uiwait(sessionopen(pathname, handles));
    uiwait(sessionopen);
%end



% --------------------------------------------------------------------
function exit_session_Callback(hObject, eventdata, handles)
% hObject    handle to exit_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%close(oamtv2_6)
delte(oamtv2_6);

% --------------------------------------------------------------------
function save_as_session_Callback(hObject, eventdata, handles)
% hObject    handle to save_as_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function option_menu_Callback(hObject, eventdata, handles)
% hObject    handle to option_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function preferences_Callback(hObject, eventdata, handles)
% hObject    handle to preferences (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function new_prefs_Callback(hObject, eventdata, handles)
% hObject    handle to new_prefs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function test_Callback(hObject, eventdata, handles)
% hObject    handle to test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function prefs_sess_Callback(hObject, eventdata, handles)
% hObject    handle to prefs_sess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        %opens preferences for editing
settingseditv1

% --------------------------------------------------------------------
function export_sess_Callback(hObject, eventdata, handles)
% hObject    handle to export_sess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function view_help_Callback(hObject, eventdata, handles)
% hObject    handle to view_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function about_help_Callback(hObject, eventdata, handles)
% hObject    handle to about_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% opens figure with information including version number creator etc.
uiwait(about)

% --------------------------------------------------------------------
function bathy_export_Callback(hObject, eventdata, handles)
% hObject    handle to bathy_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% export axes to file
global gsession_name
global filepath
if strcmp(get(handles.bathypanel,'visible'),'off')
    set(handles.bathypanel,'visible','on')
    set(handles.tlpanel,'visible','off')
end
axes=handles.axes1;
ax=gca;
ax.Units='pixels';
pos=ax.Position;  
ti=ax.TightInset;
rect=[-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+5, pos(4)+ti(2)+ti(4)+5];
imsource=getframe(axes,rect);
imwrite(imsource.cdata,[filepath 'ENV_' gsession_name '.jpg']);
% savefig(handles.axes1,[gsession_name '.jpg'])

% --------------------------------------------------------------------
function source_export_Callback(hObject, eventdata, handles)
% hObject    handle to source_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% export source data to file


% --------------------------------------------------------------------
function receiver_export_Callback(hObject, eventdata, handles)
% hObject    handle to receiver_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function sound_export_Callback(hObject, eventdata, handles)
% hObject    handle to sound_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    set(rotate3d,'Enable','on')
else
    set(rotate3d,'Enable','off')
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.bathypanel,'visible','on');
set(handles.tlpanel,'visible','off');

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.bathypanel,'visible','off');
set(handles.tlpanel,'visible','on');


% --------------------------------------------------------------------
function transloss_export_Callback(hObject, eventdata, handles)
% hObject    handle to transloss_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gsession_name
global filepath
if strcmp(get(handles.tlpanel,'visible'),'off')
    set(handles.tlpanel,'visible','on')
    set(handles.bathypanel,'visible','off')
end
axes=handles.axes2;
ax=gca;
ax.Units='pixels';
pos=ax.Position;  
ti=ax.TightInset;
rect=[-ti(1), -ti(2), pos(3)+ti(1)+ti(3)+5, pos(4)+ti(2)+ti(4)+15];
imsource=getframe(axes,rect);
imwrite(imsource.cdata,[ filepath 'TL_' gsession_name '.jpg']);


% --- Executes on selection change in source_select.
function source_select_Callback(hObject, eventdata, handles)
% hObject    handle to source_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global surfobject
global signalsources
global TL
global currsesspref
global definedenv
switch currsesspref.propagationmodel
    case 'EnergyFlux'
        cla(handles.axes2,'reset')
        plotEFlux(handles,TL(get(handles.source_select,'value')).tlarray(1).tlvector,surfobject,signalsources(get(handles.source_select,'value')),definedenv(get(handles.source_select,'value')));
        s2=char(strsplit(signalsources(get(handles.source_select,'value')).frequencyvector));
        set(handles.frequency_select,'value',1)
        set(handles.frequency_select,'string',s2)
        hold on
        plot(str2double(signalsources(get(handles.source_select,'value')).latitude),...
            str2double(signalsources(get(handles.source_select,'value')).longitude),...
            'k^');
    case 'RAM'
        s2=char(strsplit(signalsources(get(handles.source_select,'value')).frequencyvector));
        set(handles.frequency_select,'string',s2)
        %plotRAM(handles,signalsources,surfobject);
    otherwise
end
% Hints: contents = cellstr(get(hObject,'String')) returns source_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from source_select


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


% --- Executes on button press in tl_goback.
function tl_goforward_Callback(hObject, eventdata, handles)
% hObject    handle to tl_goback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signalsources
global TLtransectNo
global surfobject
global TL
global coordsmatrix
mxprof=length(TL(get(handles.source_select,'value')).profile);
if TLtransectNo+1==mxprof; TLtransectNo=1; else TLtransectNo=TLtransectNo+1; end
set(handles.tl_transect_no,'string',TLtransectNo);
% - rotate tansect to left -
lat=surfobject.XData(1,:);
lon=surfobject.YData(:,1);
SrcLat=str2double(signalsources(get(handles.source_select,'value')).latitude);
SrcLon=str2double(signalsources(get(handles.source_select,'value')).longitude);
maxzd=max(max(surfobject.ZData));
minzd=min(min(surfobject.ZData));
% - end -
% - plot new transect -
try
    h=findobj('type','line');
    if length(h)>length(sourcearrray); delete(h(1)); end
catch
end
prect=[[SrcLat,SrcLon,maxzd];[coordsmatrix(TLtransectNo,1),coordsmatrix(TLtransectNo,2),maxzd];[coordsmatrix(TLtransectNo,1),coordsmatrix(TLtransectNo,2),minzd];[SrcLat,SrcLon,minzd];[SrcLat,SrcLon,maxzd]];
line(prect(:,1),prect(:,2),prect(:,3),'color','r','Linewidth',2)
% - end -

% --- Executes on button press in tl_goback.
function tl_goback_Callback(hObject, eventdata, handles)
% hObject    handle to tl_goback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signalsources
global TLtransectNo
global surfobject
global TL
global coordsmatrix
mxprof=length(TL(get(handles.source_select,'value')).profile);
if TLtransectNo-1==0; TLtransectNo=mxprof; else TLtransectNo=TLtransectNo-1; end
set(handles.tl_transect_no,'string',TLtransectNo);
% - rotate tansect to left -
lat=surfobject.XData(1,:);
lon=surfobject.YData(:,1);
SrcLat=str2double(signalsources(get(handles.source_select,'value')).latitude);
SrcLon=str2double(signalsources(get(handles.source_select,'value')).longitude);
maxzd=max(max(surfobject.ZData));
minzd=min(min(surfobject.ZData));
% - end -
% - plot new transect -
try
    h=findobj('type','line'); 
    if length(h)>length(sourcearrray); delete(h(1)); end
catch
end
% - get new prect coordinates and plot -
prect=[[SrcLat,SrcLon,maxzd];[coordsmatrix(TLtransectNo,1),coordsmatrix(TLtransectNo,2),maxzd];[coordsmatrix(TLtransectNo,1),coordsmatrix(TLtransectNo,2),minzd];[SrcLat,SrcLon,minzd];[SrcLat,SrcLon,maxzd]];
line(prect(:,1),prect(:,2),prect(:,3),'color','r','Linewidth',2)
% - end -


% --- Executes on button press in view_prof_TL.
function view_prof_TL_Callback(hObject, eventdata, handles)
% hObject    handle to view_prof_TL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signalsources
global TL
global TLtransectNo
% - plot transmission loss graph -
TLdata=TL(get(handles.source_select,'value')).tlarray(get(handles.frequency_select,'value'));
plotTLprofile(TLtransectNo,TLdata,signalsources(get(handles.source_select,'value')),get(handles.frequency_select,'value'));
% -end -


% --- Executes on button press in run_profile.
function run_profile_Callback(hObject, eventdata, handles)
% hObject    handle to run_profile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global signalsources
global TL
% if no profiles exists for environment create all
if TLtransectNo==0
   % create profiles for each source and plot intial transect
   [prof rng]=getprofile(surfobject.ZData,Srcidx,Srcidy,c1,c2,rspace,cspace);
else
   % - run model for transect -
   
   % - end -
end


% --- Executes on button press in edit_environment.
function edit_environment_Callback(hObject, eventdata, handles)
% hObject    handle to edit_environment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global envclass
uiwait(environmentedit)

% --- Executes during object creation, after setting all properties.
function tl_transect_no_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tl_transect_no (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3
if get(hObject,'Value')==1
    set(zoom,'Enable','on')
else
    set(zoom,'Enable','off')
end


% --- Executes on selection change in frequency_select.
function frequency_select_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global surfobject
global signalsources
global TL
global currsesspref
global definedenv
switch currsesspref.propagationmodel
    case 'EnergyFlux'
        plotEFlux(handles,TL(get(handles.source_select,'value')).tlarray(get(handles.frequency_select,'value')).tlvector,surfobject,signalsources(get(handles.source_select,'value')),definedenv(get(handles.source_select,'value')));
        hold on
        plot(str2double(signalsources(get(handles.source_select,'value')).latitude),...
            str2double(signalsources(get(handles.source_select,'value')).longitude),...
            'k^');
    case 'RAM'
        %do nothing
    otherwise
        %do nothing
end
% Hints: contents = cellstr(get(hObject,'String')) returns frequency_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frequency_select


% --- Executes during object creation, after setting all properties.
function frequency_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tools_menu_Callback(hObject, eventdata, handles)
% hObject    handle to tools_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function userdefenv_Callback(hObject, eventdata, handles)
% hObject    handle to userdefenv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Callback for the user defined environemnt option from the Tools menu.
uiwait(userdefenvironment)

% --------------------------------------------------------------------
function ramcusprof_Callback(hObject, eventdata, handles)
% hObject    handle to ramcusprof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Callback for the RAM profiles option from the tools menu
global profmatrix
uiwait(ramcustprofs)
% --------------------------------------------------------------------
function cumsouexp_Callback(hObject, eventdata, handles)
% hObject    handle to cumsouexp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Callback for the cumulative sound exposure option from the Tools menu.
global TL
global filepath
global TLtransectNo
global coordsmatrix
global signalsources
global surfobject
uiwait(pathcreate)
% - map TL profiles to grid -
%create bearing matrix
global total_time
global step_num
global starting_coordinate
global source_level
if ~isempty(total_time) && ~isempty(step_num) && ~isempty(starting_coordinate) && ~isemtpy(source_level)
    cartgrid=[];
    bearingmatrix=zeros(length(coordsmatrix),2);
    for i=1:length(signalsources)
        SrcLat=str2double(signalsources(i).latitude);
        SrcLon=str2double(signalsources(i).longitude);
        for j=1:length(coordsmatrix)
            delX=SrcLat-coordsmatrix(j,1);
            delY=SrcLon-coordsmatrix(j,2);
            bearingmatrix(j,i)=tand(delX/delY);
        end
        % - create cartesian grid -
        cartgrid=[cartgrid; calccartgrid(TL,SrcLat,SrcLon,bearingmatrix(:,i))];
        % - end -
    end
    cartgrid=sortrows(cartgrid,[1,-2]);
    v_x=linspace(min(cartgrid(:,1)),max(cartgrid(:,1)));
    v_y=linspace(min(cartgrid(:,2)),max(cartgrid(:,2)));
    [xq,yq]=meshgrid(v_x,v_y);
    cartgrid=griddata(cartgrid(:,1),cartgrid(:,2),cartgrid(:,3),xq,yq);
    % - create path -
    lat=surfobject.XData(1,:);
    lon=surfobject.YData(:,1);
    range_grid.x1=min(lat); range_grid.x2=max(lat);
    range_grid.y1=min(lon); range_grid.y2=max(lon);
    [x,y,time]=walk2drand(starting_coordinate,step_num,range_grid,total_time);
    % - end -
    % - calculate cumulative sound exposure -
    cumsndexp=zeros(length(x),2);
    cumsndexp(:,1)=time;
    for i=1:length(x)
        [~,idx]=min(abs(v_x-x(i)));
        [~,idy]=min(abs(v_y-y(i)));
        if i==1; cumsndexp(i,2)=cartgrid(idx,idy); 
        else
            cumsndexp(i,2)=cumsndexp(i-1,2)+cartgrid(idx,idy); 
        end
    end
    cumsndexp=cumsndexp+source_level;
    % - end -
    % - plot to axes -
    h=figure('Name','Cumulative Sound Exposure for Random Walk (%d steps)');
    plot(cumsndexp,'b','LineWidth',2)
    xlabel('Time (s)')
    ylabel('Sound Exposure (dB)')
    title('Cumulative Sound Exposure Over Time')
    % - end -
end

% --------------------------------------------------------------------
function bckprop_Callback(hObject, eventdata, handles)
% hObject    handle to bckprop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Callback for the back propagation option from the Tools menu.
