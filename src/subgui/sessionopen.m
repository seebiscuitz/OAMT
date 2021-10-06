function varargout = sessionopen(varargin)
% SESSIONOPEN MATLAB code for sessionopen.fig
%      SESSIONOPEN, by itself, creates a new SESSIONOPEN or raises the existing
%      singleton*.
%
%      H = SESSIONOPEN returns the handle to a new SESSIONOPEN or the handle to
%      the existing singleton*.
%
%      SESSIONOPEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SESSIONOPEN.M with the given input arguments.
%
%      SESSIONOPEN('Property','Value',...) creates a new SESSIONOPEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sessionopen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sessionopen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sessionopen

% Last Modified by GUIDE v2.5 10-Jun-2016 14:41:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sessionopen_OpeningFcn, ...
                   'gui_OutputFcn',  @sessionopen_OutputFcn, ...
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


% --- Executes just before sessionopen is made visible.
function sessionopen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sessionopen (see VARARGIN)

% Choose default command line output for sessionopen
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
movegui(gcf,'center')
% UIWAIT makes sessionopen wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sessionopen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
movegui(gcf,'center')
varargout{1} = handles.output;


% --- Executes on button press in select_file.
function select_file_Callback(hObject, eventdata, handles)
% hObject    handle to select_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=findobj('Tag','oamt');
g1data=guidata(h);
[~,pathname]=uigetfile('*.dat','Choose a resume.dat file to resume that session');
% - global variables -
global currsesspref surfobject filepath gsession_name xq yq signalsources
global TL TLtransectNo envclass definedenv
% - end -
% - session info -
    filepath=pathname;
    k=strfind(pathname,'\');
    gsession_name=pathname(k(end-1)+1:k(end)-1);
    set(handles.sessionname,'string',gsession_name);
    set(handles.globalvar_status,'string','Loading...')
    fileID=fopen([pathname gsession_name '.dat'],'rt');
    inputfile=textscan(fileID,'%s');
    inputfile=inputfile{1};
    set(handles.startdate,'string',num2str(inputfile{6}));
    set(handles.username,'string',num2str(inputfile{8}));
    currsesspref=loadpreferences([pathname '\settings.txt']);
    envclass=loadenvclass([pathname '\data\env.dat']);
    definedenv=loadudeclass(pathname);
    set(handles.globalvar_status,'string','Done')
    set(g1data.bathy_export,'Enable','off');
    set(g1data.source_export,'Enable','off');
    set(g1data.transloss_export,'Enable','off');
    set(g1data.sound_export,'Enable','off');
    set(g1data.edit_environment,'Enable','on');
    set(handles.globalvars,'Value',1);
    set(g1data.pushbutton1,'Enable','on');
    figure(sessionopen)
% - end -
% - load surface data -
    try
        figure(sessionopen)
        set(handles.envdata_status,'string','Loading...');
        load([pathname '\data\surfobj.mat'],'surfaceobject');
        surfobject=surfaceobject;
        set(handles.envdata_status,'string','Loading...');
        cla(g1data.axes1,'reset')
        decimatestep=round(100/str2double(currsesspref.scalefactor));
        set(handles.envdata_status,'string','Creating env...');
        axes(g1data.axes1)
        [plotdata, xq, yq]=decimateplot(surfobject,decimatestep);
        set(handles.envdata_status,'string','Plotting Data...');
        plotsurface(plotdata, xq, yq);
        set(g1data.environment_data,'string','Successfully loaded data from session')
        set(g1data.scalenote,'string',['Note: Environment is presented at ' currsesspref.scalefactor '% scale factor.']);
        set(g1data.bathy_export,'Enable','on');
        set(handles.envdata_status,'string','Done');
        set(handles.envdata,'Value',1);
        figure(sessionopen)
    catch
        set(handles.envdata_status,'string','Error');
    end
% - end -
% - load sources from file -
    try
        figure(sessionopen)
        signalsources=loadsources(filepath);
        set(handles.sourcedata_status,'string','Loading...');
        for i=1:length(signalsources)
            set(handles.sourcedata_status,'string',sprintf('Loading %d/%d',i,length(signalsources)));
            if i==1; 
                s=char(signalsources(i).sourcelabel); 
            else
                s=char(char(s), signalsources(i).sourcelabel); 
            end
        end
        set(g1data.source_select,'string',s);
        set(g1data.source_select,'enable','on');
        figure(sessionopen)
    catch
        set(handles.sourcedata_status,'string','Error');
    end
% - end -
% - plot sources to surface -
    if not(isempty(signalsources))
        %plot onto bathymetry
        set(handles.sourcedata_status,'string','Plotting...');
        hold on
        h=findobj('type','line');
        if ~isempty(h)
            delete(h)
        end
        for i=1:length(signalsources)
            set(handles.sourcedata_status,'string',sprintf('Plotting %d/%d',i,length(signalsources)));
            axes(g1data.axes1);
            plot3(str2double(signalsources(i).latitude),str2double(signalsources(i).longitude),-1*str2double(signalsources(i).depth),'k^');
        end
        grid on
        hold off
        set(g1data.runpropagationmodel,'Enable','on');
        set(handles.sourcedata_status,'string','Done');
        set(handles.sourcedata,'Value',1);
    end
    hold off
% - end -
% - load and plot TL data -
    try
        figure(sessionopen)
        set(handles.tldata_status,'string','Loading...');
        filepath=pathname;
        switch currsesspref.propagationmodel
            case 'EnergyFlux'
                % - load and plot TL eflux data -
                load([pathname 'data\EnergyFlux\TL.mat'],'TL');
                TL=TL;
                for i=1:length(signalsources)
                    if i==1; s=char(signalsources(1).sourcelabel); else
                        s=char(char(s), signalsources(i).sourcelabel);
                    end
                end
                s2=char(strsplit(signalsources(1).frequencyvector));
                set(g1data.source_select,'string',s)
                set(g1data.frequency_select,'string',s2)
                %plot TL
                figure(oamtv2_6)
                plotEFlux(g1data,TL(1).tlarray(1).tlvector,surfobject,signalsources(1),definedenv(1));
                set(handles.tldata_status,'string','Plotting...');
                % - end -
                set(handles.tldata_status,'string','Done');
                set(handles.tldata,'Value',1);
                figure(sessionopen)
                %disp('Eflux plotted')
            case 'RAM'
                % - load and plot TL RAM data - 
                load([pathname 'data\RAM\TL.mat'],'TL');
                TL=TL;
                for i=1:length(signalsources)
                    if i==1; s=char(signalsources(1).sourcelabel); else
                        s=char(char(s), signalsources(i).sourcelabel);
                    end
                end
                s2=char(strsplit(signalsources(1).frequencyvector));
                set(g1data.source_select,'string',s)
                set(g1data.frequency_select,'string',s2)
                plotRAM(g1data,signalsources,surfobject);
                %plot TL
                set(handles.tldata_status,'string','Plotting...');
                % - end -
                set(handles.tldata_status,'string','Done');
                set(handles.tldata,'Value',1);
                figure(sessionopen)
            otherwise
                set(handles.tldata_status,'string','Error');
                figure(sessionopen)
        end
        %delete(waithandle);
    catch
       set(handles.tldata_status,'string','Error');       
       figure(sessionopen)
    end 
% - end -
% - load path -
    set(handles.pathdata_status,'string','Error');
    figure(sessionopen)
% - end -
% - load sound exposure -
    set(handles.expdata_status,'string','Error');
    figure(sessionopen)
% - end -
% - set text fields -
    format shortg;
    a=clock;
    sessres=sprintf('%02d:%02d:%02d', a(4), a(5), round(a(6)));
    set(g1data.inputloc,'string','not included in directory...');
    set(g1data.session_started,'string',['Session Resumed: ' sessres]);
    set(g1data.pushbutton6,'Enable','on');
    set(g1data.create_source,'Enable','on');
    set(g1data.session_name,'string',sprintf('Session Name: %s',gsession_name));
    set(handles.ok_button,'Enable','on');
    figure(sessionopen)
    % - end -



% --- Executes on button press in ok_button.
function ok_button_Callback(hObject, eventdata, handles)
% hObject    handle to ok_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    uiresume(oamtv2_6);
    delete(sessionopen);
