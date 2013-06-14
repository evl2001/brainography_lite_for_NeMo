function newStruct = importChaCoStruct(ChaCoResults, plotOutputOptions)

newStruct = [newRenderStruct newRenderStruct];

atlassize = length(ChaCoResults.Regions);
newStruct(1).numberROI = atlassize;
atFileName = getAtlas(atlassize);
newStruct(1).brain_at = spm_read_vols(spm_vol(atFileName));

newStruct(1).regionvalues = num2cell(zeros(atlassize,5));
newStruct(1).regionvalues(:,1) = num2cell([1:atlassize]');
newStruct(1).regionvalues(:,2) = num2cell(ChaCoResults.Regions');
newStruct(1).regionvalues(:,3:5) = num2cell(getRGBTriple(hot(200), min(ChaCoResults.Regions), max(ChaCoResults.Regions), ChaCoResults.Regions'));
newStruct(1).brain_colormaprange = [min(ChaCoResults.Regions) max(ChaCoResults.Regions)];
% colorMapOpts = {'autumn'; 'bone'; 'cool'; 'hot'; 'jet'; 'spring'; 'summer'; 'winter'};
newStruct(1).brain_colormapidx = 4;

% Functionality = hemisphere display choice
newStruct(1).custom_colormap = ones(atlassize,1);
newStruct(2).custom_colormap = 1;

newStruct(1).pipeColorHyperCube = ChaCoResults.nLocalMets;

% % Set image properties
if plotOutputOptions.SurfPlot.flag
    newStruct(1).opacity = 1;
    newStruct(1).singleColorFlag = 0;
elseif plotOutputOptions.GBPlot.flag
    newStruct(1).opacity = 0.08;
    newStruct(1).singleColorFlag = 1;
    newStruct(1).nodes = 1;
    
    res = 0;
    i = 1;
    
    localPlot = [plotOutputOptions.GraphPlot.Local.EF plotOutputOptions.GraphPlot.Local.BC ...
        plotOutputOptions.GraphPlot.Local.CP plotOutputOptions.GraphPlot.Local.MD ...
        plotOutputOptions.GraphPlot.Local.EC plotOutputOptions.GraphPlot.Local.CC];
    
    for i = 1:length(localPlot)
        res = localPlot(i);
        if res
            res = i;    
            break;
        end
    end

    newStruct(1).nodeStyle = res;
    newStruct(1).nodeProps = num2cell(zeros(atlassize,3));
    
    newStruct(1).nodeProps(:,1) = num2cell([1:atlassize]');
    newStruct(1).nodeProps(:,2) = num2cell(ChaCoResults.nLocalMets(i,:)');
    newStruct(1).nodeProps(:,3) = num2cell(setLobeSchema(atlassize,plotOutputOptions.plotlobecolor,ChaCoResults.nLocalMets(i,:)'));    
end

newStruct(1).brain_colormaprange = [min(ChaCoResults.Regions) max(ChaCoResults.Regions)];

newStruct(2).nodeSchema = plotOutputOptions.plotlobecolor;
newStruct(2).renderRes = 1;
newStruct(2).saveImages = 1;
newStruct(2).figstr = ['ChaCo_' num2str(atlassize) '_'];

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
% plotOutputOptions.plotlobecolor = 1,2 or 3

% 
% newStruct=struct('volString','','brain_at',[],'dim',[],'mat',[],'opacity',1.0, ...
%     'regionvalues',[],'singleColorFlag',0,'singleColor',[0.4792    0.5625    0.5625],'brain_colormap','bone','custom_colormap',[], ...
%     'brain_colormapidx',1,'brain_colormaprange',[],'nodes',0,'pipes',0, 'connectivityMatrix',[], ...
%     'nodeScale',2.5,'nodeSchema',[],'nodeProps',[],'nodeStyle',1,'pipeScale',1.5, ...
%     'pipeScheme',1,'pipeColorHyperCube',[],'pipeCouplet',[rand(1,3);rand(1,3)], ...
%     'pipeColorMap','jet','pipeCoupletThreshold',50,'pipeStyle',1,'pipeUniform',0,'renderRes',2, ...
%     'currentVol',1,'saveImages',1,'saveMovie',0,'figstr','NeMo','mainHandle',[],'numberROI',[]);

