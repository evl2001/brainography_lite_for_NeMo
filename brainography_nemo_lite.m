function varargout = brainography_nemo_lite(varargin)
dbstop if error
% BRAINOGRAPHY_NEMO_LITE MATLAB code for brainography_nemo_lite.fig
%      BRAINOGRAPHY_NEMO_LITE, by itself, creates a new BRAINOGRAPHY_NEMO_LITE or raises the existing
%      singleton*.
%
%      H = BRAINOGRAPHY_NEMO_LITE returns the handle to a new BRAINOGRAPHY_NEMO_LITE or the handle to
%      the existing singleton*.
%
%      BRAINOGRAPHY_NEMO_LITE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BRAINOGRAPHY_NEMO_LITE.M with the given input arguments.
%
%      BRAINOGRAPHY_NEMO_LITE('Property','Value',...) creates a new BRAINOGRAPHY_NEMO_LITE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before brainography_nemo_lite_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to brainography_nemo_lite_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help brainography_nemo_lite

% Last Modified by GUIDE v2.5 22-May-2013 13:21:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @brainography_nemo_lite_OpeningFcn, ...
    'gui_OutputFcn',  @brainography_nemo_lite_OutputFcn, ...
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


% --- Executes just before brainography_nemo_lite is made visible.
function brainography_nemo_lite_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to brainography_nemo_lite (see VARARGIN)

% Choose default command line output for brainography_nemo_lite
handles.output = hObject;
% setappdata(handles.output,'mainHandle',handles.output);
fileIn = varargin{1};
handles.ChaCoResults = fileIn.ChaCoResultsFile;

startupStruct = setChaCoScene(handles, fileIn);


guidata(hObject, handles);
setappdata(handles.output,'renderStruct',startupStruct);

% Update handles structure
% guidata(hObject, handles);
% Reserve initial guidata with "Settings" for rendering that can later be
% modified by the user and won't be deleted if the
% guidata(hObject,struct('volString','Settings','brain_at',[],'renderRes',2,'currentVol',1,'saveImages',0,'saveMovie',0));



% UIWAIT makes brainography_nemo_lite wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = brainography_nemo_lite_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version ostore struct in guif MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1}=hObject;
% varargout{2}=handles; %If I can find some way to output volume struct to
% command line
% disp(hObject);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp(guihandles(hObject));
disp(handles);
% EXECUTE FULL-SCALE IMAGE GENERATION USING GUIDATA(1:end-1)
figure;
BrainographyRender(handles,gca,2);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
handles(handles(end).currentVol).opacity = str2num(get(hObject,'String'));
guidata(hObject,handles);
disp(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
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


H=guihandles(hObject);
volVal=get(H.popupmenu1,'Value');
volString=get(H.popupmenu1,'String');

if volVal ~= size(volString,1)  %add-volume option should always be last option in menu
    % clear/delete popupmenu entry
    volString(volVal)=[];
    set(H.popupmenu1,'String',volString); %update popupmenu1
    set(H.popupmenu1,'Value',1);
    handles(volVal)=[]; % clear the removed vol from guidata/handles
    guidata(hObject,handles);
    if length(handles) == 1
        defaultGUI(H);
    else
        populateGUI(H,handles(1))
    end
elseif length(handles) == 1
    defaultGUI(H);    
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, ~, handles) % Launch CM chooser
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
waitfor(cm_choose(hObject));
H = guihandles(hObject);
handles = guidata(hObject);
if ~isempty(handles(handles(end).currentVol).connectivityMatrix)
    set(H.checkbox4,'Enable','On');
    set(H.pushbutton10,'Enable','On');% How to get connectivity matrix back to this GUI? With handle?
else
    set(H.checkbox4,'Enable','Off');
    set(H.pushbutton10,'Enable','Off');
end

% --- Executes on button press in checkbox1. Nodes on/off option
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
currentVol = handles(end).currentVol;
H = guihandles(hObject);
handles(currentVol).nodes=get(hObject, 'Value');
nodeProps = handles(currentVol).nodeProps;

if handles(currentVol).nodes
    if isempty(nodeProps);
        at = handles(currentVol).brain_at;
        numberROI = unique(at(find(at~=0)));
        nodeProps = cell(size(numberROI,1),3);
        nodeProps(:,1) = num2cell(numberROI);
        if ~isempty(handles(currentVol).connectivityMatrix)
            nodeProps(:,2) = num2cell(sum(handles(currentVol).connectivityMatrix,2));
        else
            nodeProps(:,2) = num2cell(numberROI);
        end
        nodeProps(:,3) = num2cell(ones(size(numberROI)));
        handles(currentVol).nodeProps = nodeProps;
    end
    if isempty(handles(currentVol).nodeSchema)
        handles(currentVol).nodeSchema = rand(1,3);
    end
    set(H.pushbutton8,'Enable','On');
else
    set(H.pushbutton8,'Enable','Off');
end
guidata(hObject,handles);


% --- Executes on button press in checkbox2.  Save Images Option
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
handles(end).saveImages=get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox3. Save Movie Option
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
handles(end).saveMovie=get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
currentVol = handles(end).currentVol;
handles(currentVol).pipes=get(hObject,'Value');
H = guihandles(hObject);

if handles(currentVol).pipes
    set(H.pushbutton10,'Enable','On');
    pipeColorHyperCube = handles(currentVol).pipeColorHyperCube;
    CM = handles(currentVol).connectivityMatrix;
    numberROI = size(CM,1);
    if isempty(pipeColorHyperCube) || numberROI ~= size(pipeColorHyperCube,1)
        handles(currentVol).pipeScheme = 1;
        pipeColorHyperCube = zeros(numberROI, numberROI, 3, 3);
        tmp = zeros(numberROI, numberROI);
        for i=1:3
            tmp(:) = rand;
            pipeColorHyperCube(:,:,i,1) = tmp;
        end
        handles(currentVol).pipeColorHyperCube = pipeColorHyperCube;
    end
else
    set(H.pushbutton10,'Enable','Off');
end
guidata(hObject,handles);

function resetMyAxes(H)
ac = allchild(H.axes1);
for i = 1:size(ac,1)
    delete(ac(i));
end
view([1 0 0]);
clmo(handlem('light'));
if get(H.checkbox5,'Value')
    set(H.checkbox5,'Value',0);
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

H = guihandles(hObject);
handles(end).saveMovie = 0;
handles(end).saveImage = 0;
%cla reset;
resetMyAxes(H);

if length(handles) > 1
    BrainographyRender(handles,H.axes1,3);
    view([1 1 0]);
end

function populateGUI(H, popVal)


set(H.pushbutton14,'Value',popVal.singleColor);



function defaultGUI(H)

resetMyAxes(H);



% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
view([1 0 0]);

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
view([0 0 1]);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
view([0 1 0]);


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5
clval = get(hObject, 'Value');
clmo(handlem('light'))
if clval
    camlight left;
end
    

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
H = getappdata(handles.output,'renderStruct');




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



% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
V = uisetcolor(get(hObject,'BackgroundColor'));
set(hObject,'BackgroundColor',V);
% 
% currentVol = handles(end).currentVol;
% handles(currentVol).singleColor = V;
% regionvalues = handles(currentVol).regionvalues;
% numberROI = size(regionvalues,1);
% regionvalues(:,3:5) = num2cell(repmat(V,numberROI,1));
% handles(currentVol).regionvalues = regionvalues;
% guidata(hObject,handles);


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
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
schemaVal = get(handles.popupmenu5,'Value');
schemaStr = get(handles.popupmenu5,'String');

setLobeSchema(handles, schemaStr{schemaVal});
% 
% function setLobeSchema(schemaChoice)
% H = getappdata(handles.output,'renderStruct');
% 
% if 
% schema = get

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

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
resetMyAxes;

% --- Executes when selected object is changed in uipanel6.
function uipanel6_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel6 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton1' %86 regions
        % Code for when radiobutton1 is selected.
        LobeStrings = {'Standard Lobes'; 'Functional 7-atlas'};
        set(handles.popupmenu5,'Enable','On');
        set(handles.popupmenu5,'Value',1);
        set(handles.popupmenu5,'String',LobeStrings);
    case 'radiobutton2'
        % Code for when radiobutton2 is selected.
        set(handles.popupmenu5,'Value',1);
        LobeStrings = {'Standard Lobes'};
        set(handles.popupmenu5,'String',LobeStrings);
        set(handles.popupmenu5,'Enable','Off');
    otherwise
        disp('Oh no.');
        % Code for when there is no match.
end


function lobesList = getLobes(lobeNum)
switch lobeNum
    case 116
        % list of lobe regions
        % 1 = frontal, 2 = parietal, 3 = occipital, 4 = temporal, 5 = subcortical,
        % 6 = cerebellum
        lobes = zeros(116,1);
        lobes(1:28) = 1;
        lobes([29:40, 71:78]) = 5;
        lobes(43:54) = 3;
        lobes([55:56, 79:90]) = 4;
        lobes(57:70) = 2;
        lobes(91:116) = 6;
        % new mods in limbic system
        lobes([29, 30]) = 1;  % insula
        lobes([31, 32]) = 1;  % ant cing
        lobes([33, 34]) = 1; % mid cing
        lobes([35, 36]) = 2; % post cing
        lobes([37, 38]) = 5; % hippo
        lobes([39, 40]) = 4; % parahippo
        lobes([41, 42]) = 4; % parahippo
        lobesList = num2cell(lobes);
        
    case 86
        lobeColors86 = zeros(1,86);
        
        % Frontal (blue)
        a = [3 11 13 16 17 18 19 23 26 27 31];
        lobeColors86(a) = 1;
        lobeColors86(a + 34) = 1;
        
        % Parietal (magenta)
        a =[7 21 24 28 30];
        lobeColors86(a) = 2;
        lobeColors86(a + 34) = 2;
        
        % Temporal (green)
        a = [1 5 6 8 14 15 29 32 33];
        lobeColors86(a) = 3;
        lobeColors86(a + 34) = 3;
        
        % Occipital (red)
        a = [4 10 12 20];
        lobeColors86(a) = 4;
        lobeColors86(a + 34) = 4;
        
        % Cingulate (cyan)
        a = [2 9 22 25];
        lobeColors86(a) = 5;
        lobeColors86(a + 34) = 5;
        
        % Everywhere else (black)
        ilobe = (lobeColors86 == 0);
        lobeColors86(ilobe) = 6;
        
        lobesList = num2cell(lobeColors86');
        
    case 7
        lobes = [2;4;6;1;5;1;7;5;7;1;5;1;5;7;1;2;4;7;7;1;2;4;2;7;7;6;7;3;2;4;5;5;2;4;7;4;7;1;5;1;7;5;7;1;5;1;5;7;7;2;4;7;7;1;2;7;2;7;7;6;7;3;2;4;5;5;2;4;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;];
        lobes(find(lobes==0)) = 8;
        lobesList = num2cell(lobes);
end

function nodeSchema = getNodeSchema(lobeChoice)
if isequal(lobeChoice,'seven')
	nodeSchema =   [0 0 1; %blue: Visual           
                1 0 1; %magenta: Somatomotor
                0 1 0; %green: Dorsal Attn
                1 0 0; %red: Ventral Attn
                0 1 1; %cyan: Limbic  
                1 1 0; %yellow: Fronto-pareital 
                0 0 0; %black: Default Mode   
                1 0.5 0]; %orange Cerebellar/SubCort
else
    nodeSchema = [0 0 1; %blue: Frontal           
                1 0 1; %magenta: Parietal
                0 1 0; %green: Temporal
                1 0 0; %red: Occipital
                0 1 1; %cyan: Cingulate 
                0 0 0];%black: everyewhere else
end

% --- Executes when selected object is changed in uipanel7.
function uipanel7_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel7 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton3'
        % Code for when radiobutton3 is selected.
        set(handles.popupmenu5,'Enable','On');
        set(handles.pushbutton14,'Enable','On');
        set(handles.popupmenu3,'Enable','Off');
    case 'radiobutton4'
        % Code for when radiobutton4 is selected.
        set(handles.popupmenu5,'Enable','Off');
        set(handles.pushbutton14,'Enable','Off');
        set(handles.popupmenu3,'Enable','On');
    otherwise
        disp('Oh no.');
        % Code for when there is no match.
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
