function [BasinGraph, LocalMinIndex,r, Cost, Path,E] = main(Param)
%% Main 2018/09/03 by T. Ezaki
%% This program estimates a maximum entropy distribution
%% using the maximum-likelihood method.
%% Modified by P. Khanra on 2022/10/22

if nargin > 0
    ProcessType     = Param.ProcessingType; % ProcessType
                                            % Energy Landscape Construction: 1
                                            % Individual Analysis: 2
                                            
    fReadBasinData  = Param.fReadBasinData; % Read Basin Data or not 
                                            % (in case of Individual Analysis)
                                            
    BasinDataName = Param.BasinDataFile;    % Basin Data for testing purpose
                                            
    InputFileName = Param.InputFile;        % Input File Name for testing purpose

    DataType = Param.DataType;              % Data Type: continuous data = 1, binarized data = 2
    
    OutputFolder = Param.OutputFolder;      % Output folder   
else
    % load sampleParam��ݒ肷�邱�ƁB
    Param = [];
    
    ProcessType     = 2;                    % ProcessType
                                            % Energy Landscape Construction: 1
                                            % Individual Analysis: 2
                                            
    fReadBasinData  = false;                % Read Basin Data or not 
                                            % (in case of Individual Analysis)
                                            
    BasinDataName = 'BasinData_test.mat';   % Basin Data for testing purpose
                                            
    InputFileName = {'testdata.dat', 'testdata2.dat'};         % Input File Name for testing purpose

    DataType = 2;                           % Data Type: continuous data = 1, binarized data = 2
    
    OutputFolder = [pwd '/output2/'];       % Output folder
end

switch ProcessType
    case 1
        % Energy Landscape Construction
        [BasinGraph, LocalMinIndex,r, Cost, Path,E] = ConstructEnergyLandscape(Param);
        return;
        
    case 2
        % Individual Analysis (Added from ver.2)
        if fReadBasinData
            try
                % Read Basin Data
                load(BasinDataName);
            catch ME
                errordlg('Cannot find Basin Data File.');
                return;
            end
        else
            % Construct Energy Landscape
            [BasinGraph, LocalMinIndex,r, Cost, Path,E] = ConstructEnergyLandscape(Param);
            if isempty(BasinGraph)
                return;
            end
        end
        
        % Calculate Dynamics from Input Files
        if DataType ~= 2
            errordlg('Invalid Data Type.');
            return;
        end
        if iscell(InputFileName)
            nFiles = length(InputFileName);
        else
            nFiles = 1;
            InputFileName = {InputFileName};
        end
        
        for i=1:nFiles 
            % Read BinarizedData
            try
                binarizedData =importdata(InputFileName{i});
            catch
                errordlg('Invalid Input File.');
                return;
            end
            % State Number
            StateNumber{i} = mfunc_GetStateNumber(binarizedData);
            % Basin Number
            BasinNumber{i} = mfunc_GetBasinNumber(StateNumber{i}, BasinGraph, LocalMinIndex);
            % Dynamics
            Nmin = length(LocalMinIndex);
            Dynamics{i} = mfunc_GetDynamics(BasinNumber{i}, Nmin);
            
            % Save SN
            [pathstr,tmpFileName,ext] = fileparts(InputFileName{i});
            csvwrite([OutputFolder tmpFileName '_SN.csv'], StateNumber{i});
            % Save BN
            csvwrite([OutputFolder tmpFileName '_BN.csv'], BasinNumber{i});
        end
        
        % Save Dynamics
        formatOut = 'yyyymmdd_HH_MM_SS';
        ProcessDate = datestr(now, formatOut);
        f = fopen([OutputFolder 'Dynamics_' ProcessDate '.csv'], 'w');
        fprintf(f, 'InputFile');
        for i=1:Nmin
            fprintf(f, ', Frequency of B%d', i);
        end
        for i=1:Nmin
            for j=1:Nmin
                if i == j
                    continue;
                end
                fprintf(f, ', Direct transitions from B%d to B%d', i, j);
            end
        end
        for i=1:Nmin
            for j=1:Nmin
                if i == j
                    continue;
                end
                fprintf(f, ', Transitions from B%d to B%d', i, j);
            end
        end
        fprintf(f, '\n');
        for k=1:nFiles
           fprintf(f, '%s', InputFileName{k});
           for i=1:Nmin
              fprintf(f, ', %f', Dynamics{k}.Freq(i)); 
           end
            for i=1:Nmin
                for j=1:Nmin
                    if i==j
                        continue;
                    end
                    fprintf(f, ', %f', Dynamics{k}.Dtrans(i,j)); 
                end
            end
            for i=1:Nmin
                for j=1:Nmin
                    if i==j
                        continue;
                    end
                    fprintf(f, ', %f', Dynamics{k}.Trans(i,j));
                end
            end
            fprintf(f, '\n');
        end
        
        fclose(f);
        
        % Display Dynamics
        disp('Dynamics');
        for i=1:nFiles
            disp(['FileName : ' InputFileName{i}]);
            disp('Freq = ');
            disp(Dynamics{i}.Freq);
            disp('Dtrans = ');
            disp(Dynamics{i}.Dtrans);
            disp('Trans = ');
            disp(Dynamics{i}.Trans);
        end
        
        
    otherwise
        errordlg('Setting Parameter was wrong.');
        return;
end
end

function [BasinGraph, LocalMinIndex,r,Cost,Path,E] = ConstructEnergyLandscape(Param)
% Construct Energy Landscape (main function in ver. 1)

%% Settings
if (nargin > 0) && ~isempty(Param)
    % In case of parameters set by GUI
    InputFileName   = Param.InputFile;          % Input file name
    DataType        = Param.DataType;           % Input file data type  
    threshold       = Param.Threshold;          % Threshold
    OutputFolder    = Param.OutputFolder;       % Output folder 
    fRoi            = Param.fRoi;               % Flag of using ROI name file or not
    RoiNameFile     = Param.RoiFile;            % ROI name file
    fSaveBasinList  = Param.fSaveBasinList;     % flag of save basin list or not
else
    % In case of no parameters set
    
    InputFileName = 'testdata.dat';
    %InputFileName = 'FPNdata.dat';
    % Data Type: continuous data = 1, binarized data = 2
    DataType = 2;
    % Binarization threshold
    threshold = 0.0;
    % Output folder
    OutputFolder = [pwd '/output2/'];
    % Flag of using ROI name file or not
    fRoi = false;
    % ROI name file
    RoiNameFile = [];
    % flag of save basin list or not
    fSaveBasinList = true;
end

BasinGraph = [];
LocalMinIndex = [];

% Connect Input Files if needed.
if iscell(InputFileName)
    nFiles = length(InputFileName);
else
    nFiles = 1;
    InputFileName = {InputFileName};
end

binarizedData = [];
for i=1:nFiles
    switch DataType
        case 1
            % continuous data
            %threshold =0.0; %for binarization, above (below) which ROI activity is defined to be +1 (-1).
            
            % import data: nodeMax x time points
            try
                originalData= importdata(InputFileName{i});
            catch ME
                errordlg('Invalid Input File.');
                return;
            end
            %binarize
            tmpB = pfunc_01_Binarizer(originalData,threshold);
            binarizedData = [binarizedData, tmpB];
        case 2
            % Binarized data
            try
                tmpB =importdata(InputFileName{i});
            catch ME
                errordlg('Invalid Input File.');
                return;
            end
            binarizedData = [binarizedData, tmpB];
        otherwise
            errordlg('Invalid Data Type');
            return;
    end
end

%% Main part
formatOut = 'yyyymmdd_HH_MM_SS';
ProcessDate = datestr(now, formatOut);
%%% For maximum likelihood
[h,J] = pfunc_02_Inferrer_ML(binarizedData);
%save([OutputFolder 'h_L_' num2str(Param.X) '_' num2str(Param.Y) '.mat'], 'h');
save(['h_L_' num2str(Param.X) '_' num2str(Param.Y) '.mat'], 'h');
%save([OutputFolder 'J_L_' num2str(Param.X) '_' num2str(Param.Y) '.mat'], 'J');
save(['J_L_' num2str(Param.X) '_' num2str(Param.Y) '.mat'], 'J');
%%% End of ML

[probN, prob1, prob2, rD, r] = pfunc_03_Accuracy(h, J, binarizedData);
        
%% Calculate Energy
E = mfunc_Energy(h, J);

%% Calculate Local Minima
nodeNumber = length(h);
[LocalMinIndex, BasinGraph, AdjacentList] = mfunc_LocalMin(nodeNumber, E);

%% Calculate Energy path by Dijkstra
[Cost, Path] = mfunc_DisconnectivityGraph(E, LocalMinIndex, AdjacentList);

%% Show activity pattern
% set the Name of signal before calling function by hand.
if fRoi
    Name = importdata(RoiNameFile);
else
    Name = [];
end
    
vectorList = mfunc_VectorList(nodeNumber);
mfunc_ActivityMap(vectorList, LocalMinIndex, Name);
end