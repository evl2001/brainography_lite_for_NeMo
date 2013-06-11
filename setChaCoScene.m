function startupStruct = setChaCoScene(handles, fileIn)
% 
resultsFile = fileIn.ChaCoResultsFile;

if size(resultsFile,1) == 1
    set(handles.radiobutton1,'Enable','Off');
    set(handles.radiobutton2,'Enable','Off');
else
    

switch atlassize
    case 86
        set(handles.radiobutton1,'Value',1);
    case 116
        set(handles.radiobutton2,'Value',1);
end

for i = 1:length(ChaCoResults)
newStruct = [newRenderStruct newRenderStruct];

if plotOutputOptions.SurfPlot.flag
    newStruct(1).opacity = 1;
elseif plotOutputOptions.GBPlot.flag
    newStruct(1).opacity = 0.08;
end


% plotOutputOptions.SurfPlot.flag = 0;
% plotOutputOptions.SurfPlot.PlotHemi = 'left';
% plotOutputOptions.SurfPlot.MAP = [];
% plotOutputOptions.SurfPlot.movie = 0;
% plotOutputOptions.GBPlot.flag = 0;
% plotOutputOptions.GBPlot.movie = 0;
% plotOutputOptions.BoxPlot.flag =0;
% plotOutputOptions.GraphPlot.flag = 1;
% plotOutputOptions.GraphPlot.Global = 0;
% plotOutputOptions.GraphPlot.Local.flag = 1;
% plotOutputOptions.GraphPlot.Local.EF = 0;
% plotOutputOptions.GraphPlot.Local.BC = 0;
% plotOutputOptions.GraphPlot.Local.CP = 0;
% plotOutputOptions.GraphPlot.Local.MD = 1;
% plotOutputOptions.GraphPlot.Local.EC = 0;
% plotOutputOptions.GraphPlot.Local.CC = 0;
% plotOutputOptions.figsave = '_116_AD';
