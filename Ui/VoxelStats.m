function VoxelStats()
    f = figure;
    set(0, 'DefaultUIControlFontSize', 14);
    set(0, 'DefaultUIControlFontName', 'Avenir');
    set(f, 'units', 'normalized', 'position', [0.2 0.3 0.6 0.7])
    set(f, 'menubar', 'none', 'numbertitle', 'off', 'name', 'VoxelStats');
    tgroup = uitabgroup('Parent', f, 'Position', [0.05 0.05 0.9 0.6]);

    tab1 = uitab('Parent', tgroup, 'Title', 'LM');
    tab2 = uitab('Parent', tgroup, 'Title', 'GLM');
    tab3 = uitab('Parent', tgroup, 'Title', 'ROC');
    %tab4 = uitab('Parent', tgroup, 'Title', 't-Test');

    %Main UI Controls
    lblDataFile = uicontrol('Tag', 'lblDataFile','Parent', f, 'Style', 'text', 'String', ...
    'Data File:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.025 0.90 0.1 0.05]) ;
    txtDataFile = uicontrol('Tag', 'txtDataFile','Parent', f, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.15 0.90 0.65 0.05], 'HorizontalAlignment', 'left') ;
    chooseDataFile = uicontrol('Tag', 'chooseDataFile','Parent', f, 'Style', 'pushbutton', ...
    'String', 'Browse','units', 'normalized', 'Position', [0.85 0.90 0.125 0.05], 'CallBack', {@chooseFile, txtDataFile}) ;

    lblFilter = uicontrol('Tag', 'lblFilter','Parent', f, 'Style', 'text', 'String', ...
    'Filter String:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.025 0.825 0.1 0.05]) ;
    txtFilter = uicontrol('Tag', 'txtFilter','Parent', f, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.15 0.825 0.65 0.05], ...
    'HorizontalAlignment', 'left') ;

    lblMaskFile = uicontrol('Tag', 'lblMaskFile','Parent', f, 'Style', 'text', 'String', ...
    'Mask File:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.025 0.75 0.1 0.05]) ;
    txtMaskFile = uicontrol('Tag', 'txtMaskFile','Parent', f, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.15 0.75 0.65 0.05], 'HorizontalAlignment', 'left') ;
    chooseMaskFile = uicontrol('Tag', 'chooseMaskFile','Parent', f, 'Style', 'pushbutton', ...
    'String', 'Browse','units', 'normalized', 'Position', [0.85 0.75 0.125 0.05], 'CallBack', {@chooseFile, txtMaskFile}) ;

    lblImageType = uicontrol('Tag', 'lblImageType','Parent', f, 'Style', 'text', 'String', ...
    'Image Type:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.025 0.675 0.15 0.05]) ;
    chooseImageType = uicontrol('Tag', 'chooseImageType','Parent', f, 'Style', 'popupmenu', ...
    'String', {'minc','nifty'},'units', 'normalized', 'Position', [0.15 0.675 0.25 0.05]) ;

    %UI controls in Tab1 = LM
    lblModel_lm = uicontrol('Tag', 'lblModel_lm','Parent', tab1, 'Style', 'text', 'String', ...
    'Model String:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.05 0.85 0.3 0.09]) ;
    txtModel_lm = uicontrol('Tag', 'txtModel_lm','Parent', tab1, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.25 0.85 0.7 0.09], 'HorizontalAlignment', 'left') ;

    lblMultVar_lm = uicontrol('Tag', 'lblMultVar_lm','Parent', tab1, 'Style', 'text', 'String', ...
    'Multi-value Vars:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.05 0.75 0.3 0.09]) ;
    txtMultVar_lm = uicontrol('Tag', 'txtMultVar_lm','Parent', tab1, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.25 0.75 0.7 0.09], 'HorizontalAlignment', 'left') ;

    lblCatVar_lm = uicontrol('Tag', 'lblCatVar_lm','Parent', tab1, 'Style', 'text', 'String', ...
    'Categorical Vars:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.05 0.65 0.3 0.09]) ;
    txtCatVar_lm = uicontrol('Tag', 'txtCatVar_lm','Parent', tab1, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.25 0.65 0.7 0.09], 'HorizontalAlignment', 'left') ;

    chooseMixed_lm = uicontrol('Tag', 'chooseMixed_lm','Parent', tab1, 'Style', 'checkbox', ...
    'String', 'Mixed Model', 'units', 'normalized', 'Position', [0.05 0.55 0.3 0.09]) ;

    runVS_lm = uicontrol('Tag', 'runVS_lm','Parent', tab1, 'Style', 'pushbutton', ...
    'String', 'Run','units', 'normalized', 'Position', [0.75 0.45 0.2 0.1], 'CallBack', {@runVS, 'lm'}) ;

    writePanel_lm = uipanel('Tag', 'writePanel_lm','Parent', tab1, 'units', 'normalized', ...
    'Position', [0.45 0 0.54 0.4], 'Title', 'Write Results', ...
    'FontSize',14, 'FontName', 'Avenir');
    
    lblEst_lm = uicontrol('Tag', 'lblEst_lm','Parent', writePanel_lm, 'Style', 'text', 'String', ...
    'Estimate:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.7 0.3 0.25]) ;
    chooseEst_lm = uicontrol('Tag', 'chooseEst_lm', 'Parent', writePanel_lm, 'Style', 'popupmenu', ...
     'String', {''}, 'units', 'normalized', 'Position', [0.2 0.7 0.75 0.25], ...
    'CallBack', {@chooseVariable, 'lm'}) ;

    lblVarName_lm = uicontrol('Tag', 'lblVarName_lm','Parent', writePanel_lm, 'Style', 'text', 'String', ...
    'Variable:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.4 0.3 0.25]) ;
    chooseVarName_lm = uicontrol('Tag', 'chooseVarName_lm', 'Parent', writePanel_lm, 'Style', 'popupmenu', ...
     'String', {''}, 'units', 'normalized', 'Position', [0.2 0.4 0.75 0.25]) ;

    writeResult_lm = uicontrol('Tag', 'writeResult_lm', 'Parent', writePanel_lm, 'Style', 'pushbutton', ...
    'String', 'Save','units', 'normalized', 'Position', [0.55 0.1 0.39 0.28], 'CallBack', {@saveRes, 'lm'}) ;

    rftPanel_lm = uipanel('Tag', 'rftPanel_lm','Parent', tab1, 'units', 'normalized', ...
    'Position', [0.01 0 0.43 0.4], 'Title', 'RFT MCC', ...
    'FontSize',14, 'FontName', 'Avenir');
    
    lblRftSearchVol_lm = uicontrol('Tag', 'lblRftSearchVol_lm','Parent', rftPanel_lm, 'Style', 'text', 'String', ...
    'Search Vol:',  'FontSize', 12,'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.8 0.25 0.2]) ;
    txtRftSearchVol_lm = uicontrol('Tag', 'txtRftSearchVol_lm','Parent', rftPanel_lm, 'Style', 'edit', ...
    'FontSize', 12, 'units', 'normalized', 'Position', [0.23 0.8 0.25 0.2], 'HorizontalAlignment', 'left') ;
    
    lblRftVoxelNum_lm = uicontrol('Tag', 'lblRftVoxelNum_lm','Parent', rftPanel_lm, 'Style', 'text', 'String', ...
    'Voxel Num:', 'FontSize', 12, 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.59 0.25 0.2]) ;
    txtRftVoxelNum_lm = uicontrol('Tag', 'txtRftVoxelNum_lm','Parent', rftPanel_lm, 'Style', 'edit', ...
    'FontSize', 12, 'units', 'normalized', 'Position', [0.23 0.59 0.25 0.2], 'HorizontalAlignment', 'left') ;

    lblRftFWHM_lm = uicontrol('Tag', 'lblRftFWHM_lm','Parent', rftPanel_lm, 'Style', 'text', 'String', ...
    'FWHM:', 'FontSize', 12, 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.38 0.25 0.2]) ;
    txtRftFWHM_lm = uicontrol('Tag', 'txtRftFWHM_lm','Parent', rftPanel_lm, 'Style', 'edit', ...
    'FontSize', 12, 'units', 'normalized', 'Position', [0.23 0.38 0.25 0.2], 'HorizontalAlignment', 'left') ;

    lblRftDF_lm = uicontrol('Tag', 'lblRftDF_lm','Parent', rftPanel_lm, 'Style', 'text', 'String', ...
    'DF:', 'FontSize', 12, 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.49 0.8 0.15 0.2]) ;
    txtRftDF_lm = uicontrol('Tag', 'txtRftDF_lm','Parent', rftPanel_lm, 'Style', 'edit', ...
    'FontSize', 12, 'units', 'normalized', 'Position', [0.72 0.8 0.25 0.2], 'HorizontalAlignment', 'left') ;
    
    lblRftClusterTh_lm = uicontrol('Tag', 'lblRftClusterTh_lm','Parent', rftPanel_lm, 'Style', 'text', 'String', ...
    'Cluster p-val:', 'FontSize', 12, 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.49 0.59 0.23 0.2]) ;
    txtRftClusterTh_lm = uicontrol('Tag', 'txtRftClusterTh_lm','Parent', rftPanel_lm, 'Style', 'edit', ...
    'FontSize', 12, 'String', '0.001', 'units', 'normalized', 'Position', [0.72 0.59 0.25 0.2], 'HorizontalAlignment', 'left') ;
    
    runRFT_lm = uicontrol('Tag', 'runRFT_lm', 'Parent', rftPanel_lm, 'Style', 'pushbutton', ...
    'String', 'Run','units', 'normalized', 'Position', [0.55 0.1 0.42 0.28], 'CallBack', {@runRFT, 'lm'}) ;

    %UI controls in Tab2 = GLM
    lblModel_glm = uicontrol('Parent', tab2, 'Style', 'text', 'String', ...
    'Model String:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.05 0.85 0.3 0.09]) ;
    txtModel_glm = uicontrol('Parent', tab2, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.25 0.85 0.7 0.09], 'HorizontalAlignment', 'left') ;

    lblMultVar_glm = uicontrol('Parent', tab2, 'Style', 'text', 'String', ...
    'Multi-value Vars:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.05 0.75 0.3 0.09]) ;
    txtMultVar_glm = uicontrol('Parent', tab2, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.25 0.75 0.7 0.09], 'HorizontalAlignment', 'left') ;

    lblCatVar_glm = uicontrol('Parent', tab2, 'Style', 'text', 'String', ...
    'Categorical Vars:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.05 0.65 0.3 0.09]) ;
    txtCatVar_glm = uicontrol('Parent', tab2, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.25 0.65 0.7 0.09], 'HorizontalAlignment', 'left') ;

    chooseMixed_glm = uicontrol('Parent', tab2, 'Style', 'checkbox', ...
    'String', 'Mixed Model', 'units', 'normalized', 'Position', [0.05 0.55 0.3 0.09]) ;

    lblDist_glm = uicontrol('Parent', tab2, 'Style', 'text', 'String', ...
    'Distribution:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.5 0.55 0.2 0.09]) ;
    chooseDist_glm = uicontrol('Parent', tab2, 'Style', 'popupmenu', ...
    'String', {'binomial','poisson', 'gamma', 'inverse gaussian'}, 'units', 'normalized', 'Position', [0.65 0.55 0.305 0.09]) ;

    runVS_glm = uicontrol('Parent', tab2, 'Style', 'pushbutton', ...
    'String', 'Run','units', 'normalized', 'Position', [0.75 0.45 0.2 0.1], 'CallBack', {@runVS, 'glm'}) ;

     writePanel_glm = uipanel('Tag', 'writePanel_glm','Parent', tab2, 'units', 'normalized', ...
    'Position', [0.45 0 0.54 0.4], 'Title', 'Write Results', ...
    'FontSize',14, 'FontName', 'Avenir');
    
    lblEst_glm = uicontrol('Tag', 'lblEst_glm','Parent', writePanel_glm, 'Style', 'text', 'String', ...
    'Estimate:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.7 0.3 0.25]) ;
    chooseEst_glm = uicontrol('Tag', 'chooseEst_glm', 'Parent', writePanel_glm, 'Style', 'popupmenu', ...
     'String', {''}, 'units', 'normalized', 'Position', [0.2 0.7 0.75 0.25]) ;

    lblVarName_glm = uicontrol('Tag', 'lblVarName_glm','Parent', writePanel_glm, 'Style', 'text', 'String', ...
    'Variable:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.4 0.3 0.25]) ;
    chooseVarName_glm = uicontrol('Tag', 'chooseVarName_glm', 'Parent', writePanel_glm, 'Style', 'popupmenu', ...
     'String', {''}, 'units', 'normalized', 'Position', [0.2 0.4 0.75 0.25]) ;

    writeResult_glm = uicontrol('Tag', 'writeResult_glm', 'Parent', writePanel_glm, 'Style', 'pushbutton', ...
    'String', 'Save','units', 'normalized', 'Position', [0.55 0.1 0.39 0.28], 'CallBack', {@saveRes, 'glm'}) ;

    rftPanel_glm = uipanel('Tag', 'rftPanel_glm','Parent', tab2, 'units', 'normalized', ...
    'Position', [0.01 0 0.43 0.4], 'Title', 'RFT MCC', ...
    'FontSize',14, 'FontName', 'Avenir');
    
    lblRftSearchVol_glm = uicontrol('Tag', 'lblRftSearchVol_glm','Parent', rftPanel_glm, 'Style', 'text', 'String', ...
    'Search Vol:',  'FontSize', 12,'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.8 0.25 0.2]) ;
    txtRftSearchVol_glm = uicontrol('Tag', 'txtRftSearchVol_glm','Parent', rftPanel_glm, 'Style', 'edit', ...
    'FontSize', 12, 'units', 'normalized', 'Position', [0.23 0.8 0.25 0.2], 'HorizontalAlignment', 'left') ;
    
    lblRftVoxelNum_glm = uicontrol('Tag', 'lblRftVoxelNum_glm','Parent', rftPanel_glm, 'Style', 'text', 'String', ...
    'Voxel Num:', 'FontSize', 12, 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.59 0.25 0.2]) ;
    txtRftVoxelNum_glm = uicontrol('Tag', 'txtRftVoxelNum_glm','Parent', rftPanel_glm, 'Style', 'edit', ...
    'FontSize', 12, 'units', 'normalized', 'Position', [0.23 0.59 0.25 0.2], 'HorizontalAlignment', 'left') ;

    lblRftFWHM_glm = uicontrol('Tag', 'lblRftFWHM_glm','Parent', rftPanel_glm, 'Style', 'text', 'String', ...
    'FWHM:', 'FontSize', 12, 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.38 0.25 0.2]) ;
    txtRftFWHM_glm = uicontrol('Tag', 'txtRftFWHM_glm','Parent', rftPanel_glm, 'Style', 'edit', ...
    'FontSize', 12, 'units', 'normalized', 'Position', [0.23 0.38 0.25 0.2], 'HorizontalAlignment', 'left') ;

    lblRftDF_glm = uicontrol('Tag', 'lblRftDF_glm','Parent', rftPanel_glm, 'Style', 'text', 'String', ...
    'DF:', 'FontSize', 12, 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.49 0.8 0.15 0.2]) ;
    txtRftDF_glm = uicontrol('Tag', 'txtRftDF_glm','Parent', rftPanel_glm, 'Style', 'edit', ...
    'FontSize', 12, 'units', 'normalized', 'Position', [0.72 0.8 0.25 0.2], 'HorizontalAlignment', 'left') ;
    
    lblRftClusterTh_glm = uicontrol('Tag', 'lblRftClusterTh_glm','Parent', rftPanel_glm, 'Style', 'text', 'String', ...
    'Cluster p-val:', 'FontSize', 12, 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.49 0.59 0.23 0.2]) ;
    txtRftClusterTh_glm = uicontrol('Tag', 'txtRftClusterTh_glm','Parent', rftPanel_glm, 'Style', 'edit', ...
    'FontSize', 12, 'String', '0.001', 'units', 'normalized', 'Position', [0.72 0.59 0.25 0.2], 'HorizontalAlignment', 'left') ;
    
    runRFT_glm = uicontrol('Tag', 'runRFT_glm', 'Parent', rftPanel_glm, 'Style', 'pushbutton', ...
    'String', 'Run','units', 'normalized', 'Position', [0.55 0.1 0.42 0.28], 'CallBack', {@runRFT, 'glm'}) ;


    %UI controls in Tab3 = ROC
    lblDataCol_roc = uicontrol('Tag', 'lblDataCol_roc','Parent', tab3, 'Style', 'text', 'String', ...
    'Image Column:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.05 0.85 0.3 0.09]) ;
    txtDataCol_roc = uicontrol('Tag', 'txtDataCol_roc','Parent', tab3, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.25 0.85 0.7 0.09], 'HorizontalAlignment', 'left') ;

    lblGroupCol_roc = uicontrol('Tag', 'lblGroupCol_roc','Parent', tab3, 'Style', 'text', 'String', ...
    'Grouping Column:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.05 0.75 0.3 0.09]) ;
    txtGroupCol_roc = uicontrol('Tag', 'txtGroupCol_roc','Parent', tab3, 'Style', 'edit', ...
    'units', 'normalized', 'Position', [0.25 0.75 0.7 0.09], 'HorizontalAlignment', 'left') ;

    runVS_roc = uicontrol('Tag', 'runVS_roc','Parent', tab3, 'Style', 'pushbutton', ...
    'String', 'Run','units', 'normalized', 'Position', [0.75 0.45 0.2 0.1], 'CallBack', {@runVS, 'roc'}) ;

    writePanel_roc = uipanel('Tag', 'writePanel_roc','Parent', tab3, 'units', 'normalized', ...
    'Position', [0.45 0 0.54 0.4], 'Title', 'Write Results', ...
    'FontSize',14, 'FontName', 'Avenir');
    
    lblEst_roc = uicontrol('Tag', 'lblEst_roc','Parent', writePanel_roc, 'Style', 'text', 'String', ...
    'Estimate:', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.7 0.3 0.25]) ;
    chooseEst_roc = uicontrol('Tag', 'chooseEst_roc', 'Parent', writePanel_roc, 'Style', 'popupmenu', ...
     'String', {''}, 'units', 'normalized', 'Position', [0.2 0.7 0.75 0.25]) ;

    writeResult_roc = uicontrol('Tag', 'writeResult_roc', 'Parent', writePanel_roc, 'Style', 'pushbutton', ...
    'String', 'Save','units', 'normalized', 'Position', [0.55 0.1 0.39 0.28], 'CallBack', {@saveRes, 'roc'}) ;

    lblStatus = uicontrol('Tag', 'lblStatus','Parent', f, 'Style', 'text', 'String', ...
    'VoxelStats v1.1 - Idle', 'HorizontalAlignment', 'left', 'units', 'normalized', 'Position', [0.01 0.0 0.4 0.05]) ;
    
    handles = guihandles(f);
    guidata(f, handles)
end