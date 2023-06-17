clear all
nodeNum=7;      %No of ROIs
participants=['1','2'];     %Participants name/index
sessions=['1','2'];         %session id
thres=0.22;     %Threshold for the branch length
mkdir('Output_Folder')
out_folder=[pwd '/Output_Folder/'];
d1_Interaction_strength=[]; d1_Hamming_dist=[]; d1_Cosine_dist=[]; d1_nbld=[];
d2_Interaction_strength=[]; d2_Hamming_dist=[]; d2_Cosine_dist=[]; d2_nbld=[];

%% Within Participants %%
    for i=1:length(participants)
        for j=1:length(sessions)
            tbl(j)=0;

            Param.X=i;
            Param.Y=j;
            Param.ProcessingType=1;
            Param.InputFile=['SampleData_Binarized_Participant_' participants(i) '_Session_' sessions(j) '.mat'];
            Param.DataType=2;
            Param.fReadBasinData=false;
            Param.BasinDataFile='BasinData_test.mat';
            Param.OutputFolder=out_folder;
            Param.Threshold=0;
            Param.fRoi=true;
            Param.RoiFile='roiname.dat';
            Param.fSaveBasinList=true;
        
            [BasinGraph, LocalMinIndex,r, Cost, Path,E] = main(Param);
            p=['BasinGraph' num2str(j) '=BasinGraph'];
            eval(p);
            
            load(['J_L_' num2str(i) '_' num2str(j) '.mat'])
            J_L{j}=J;

            [tbl,index]=branch_index(thres,LocalMinIndex,Cost,E);
            p=['tbl' num2str(j) '=tbl; index' num2str(j) '=index;'];
            eval(p);
        end

            d=abs(J_L{1}-J_L{2});
            d1_Interaction_strength=[d1_Interaction_strength, mean(d(:))];
            d1_Hamming_dist=[d1_Hamming_dist, Hamming_Distance(nodeNum,index1,index2)];
            d1_Cosine_dist=[d1_Cosine_dist, Cosine_distance(nodeNum,BasinGraph1,BasinGraph2,index1,index2)];
            d1_nbld=[d1_nbld, abs(tbl1-tbl2)/max(tbl1,tbl2)];    %Normalized branch length difference
    end

%% Between Participants %%
    for i=1:length(sessions)
        for j=1:length(participants)
            tbl(j)=0;

            Param.X=j;
            Param.Y=i;
            Param.ProcessingType=1;
            Param.InputFile=['SampleData_Binarized_Participant_' participants(j) '_Session_' sessions(i) '.mat'];
            Param.DataType=2;
            Param.fReadBasinData=false;
            Param.BasinDataFile='BasinData_test.mat';
            Param.OutputFolder=out_folder;
            Param.Threshold=0;
            Param.fRoi=true;
            Param.RoiFile='roiname.dat';
            Param.fSaveBasinList=true;
        
            [BasinGraph, LocalMinIndex,r, Cost, Path,E] = main(Param);
            p=['BasinGraph' num2str(j) '=BasinGraph'];
            eval(p);

            load(['J_L_' num2str(j) '_' num2str(i) '.mat'])
            J_L{j}=J;

            [tbl,index]=branch_index(thres,LocalMinIndex,Cost,E);
            p=['tbl' num2str(j) '=tbl; index' num2str(j) '=index;'];
            eval(p);
        end
        
            d=abs(J_L{1}-J_L{2});
            d2_Interaction_strength=[d2_Interaction_strength,mean(d(:))];
            d2_Hamming_dist=[d2_Hamming_dist, Hamming_Distance(nodeNum,index1,index2)];
            d2_Cosine_dist=[d2_Cosine_dist, Cosine_distance(nodeNum,BasinGraph1,BasinGraph2,index1,index2)];
            d2_nbld=[d2_nbld, abs(tbl1-tbl2)/max(tbl1,tbl2)];    %Normalized branch length difference
    end
    d1_Interaction_strength=mean(d1_Interaction_strength);
    d1_Hamming_dist=mean(d1_Hamming_dist);
    d1_Cosine_dist=mean(d1_Cosine_dist);
    d1_nbld=mean(d1_nbld);

    d2_Interaction_strength=mean(d2_Interaction_strength);
    d2_Hamming_dist=mean(d2_Hamming_dist);
    d2_Cosine_dist=mean(d2_Cosine_dist);
    d2_nbld=mean(d2_nbld);

    ND_Interaction_strength=d2_Interaction_strength/d1_Interaction_strength;
    ND_Hamming_dist=d2_Hamming_dist/d1_Hamming_dist;
    ND_Cosine_dist=d2_Cosine_dist/d1_Cosine_dist;
    ND_nbld=d2_nbld/d1_nbld;
    save Discrepancy.mat ND_Interaction_strength ND_Hamming_dist ND_Cosine_dist ND_nbld
