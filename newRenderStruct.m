function newStruct = newRenderStruct
%Initialize new renderstruct
newStruct=struct('volString','','brain_at',[],'dim',[],'mat',[],'opacity',1.0, ...
    'regionvalues',[],'singleColorFlag',0,'singleColor',[0.4792    0.5625    0.5625],'brain_colormap','bone','custom_colormap',[], ...
    'brain_colormapidx',1,'brain_colormaprange',[],'nodes',0,'pipes',0, 'connectivityMatrix',[], ...
    'nodeScale',2.5,'nodeSchema',[],'nodeProps',[],'nodeStyle',1,'pipeScale',1.5, ...
    'pipeScheme',1,'pipeColorHyperCube',[],'pipeCouplet',[rand(1,3);rand(1,3)], ...
    'pipeColorMap','jet','pipeCoupletThreshold',50,'pipeStyle',1,'pipeUniform',0,'renderRes',2, ...
    'currentVol',1,'saveImages',0,'saveMovie',0,'figstr','NeMo','mainHandle',[],'numberROI',[]);

% 
% function newStruct = newRenderStruct(atlassize)
% %Initialize new renderstruct
% if atlassize == 116
%     newStruct=struct('brain_at',[],'dim',[],'mat',[],'opacity',1.0, ...
%         'regionvalues',[],'singleColorFlag',0,'singleColor',[0.4792    0.5625    0.5625],'brain_colormap','autumn','custom_colormap',[], ...
%         'brain_colormapidx',1,'nodes',0,'pipes',0, 'connectivityMatrix',zeros(atlassize,atlassize), ...
%         'nodeScale',3.5,'nodeSchema',getNodeSchema('aal'),'nodeProps',num2cell([[1:atlassize]' ones(atlassize,1) ]),'nodeStyle',1,'pipeScale',1.5, ...
%         'pipeScheme',1,'pipeColorHyperCube',[],'pipeCouplet',[rand(1,3);rand(1,3)], ...
%         'pipeColorMap','jet','pipeCoupletThreshold',50,'pipeStyle',1,'renderRes',2, ...
%         'currentVol',1,'saveImages',1,'saveMovie',0,'figstr','NeMo116','mainHandle',[],'numberROI',atlassize);
% elseif atlassize == 86
%     newStruct=struct('brain_at',[],'dim',[],'mat',[],'opacity',1.0, ...
%         'regionvalues',[],'singleColorFlag',0,'singleColor',[0.4792    0.5625    0.5625],'brain_colormap','autumn','custom_colormap',[], ...
%         'brain_colormapidx',1,'nodes',0,'pipes',0, 'connectivityMatrix',zeros(atlassize,atlassize), ...
%         'nodeScale',3.5,'nodeSchema',[],'nodeProps',[],'nodeStyle',1,'pipeScale',1.5, ...
%         'pipeScheme',1,'pipeColorHyperCube',[],'pipeCouplet',[rand(1,3);rand(1,3)], ...
%         'pipeColorMap','jet','pipeCoupletThreshold',50,'pipeStyle',1,'renderRes',2, ...
%         'currentVol',1,'saveImages',1,'saveMovie',0,'figstr','NeMo86','mainHandle',[],'numberROI',atlassize);
% end