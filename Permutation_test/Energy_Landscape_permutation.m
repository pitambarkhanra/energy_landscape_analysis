clear all
nodeNum=7;      %No of ROIs
participants=['1','2'];     %Participants name/index
NP=length(participants);
sessions=['1','2'];         %session id
NS=length(sessions);
thres=0.22;     %Threshold for the branch length
NOP=10;         % No. of permutation
load ND_values.mat
mkdir('Output_Folder')
out_folder=[pwd '/Output_Folder/'];
for i=1:NP
        for j=1:NS
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
            
            [tbl,index]=branch_index(thres,LocalMinIndex,Cost,E);

            p=['tbl_' num2str(i) '_' num2str(j) '=tbl'];
            eval(p);
            p=['BasinGraph_' num2str(i) '_' num2str(j) '=BasinGraph'];
            eval(p);
            p=['index_' num2str(i) '_' num2str(j) '=index'];
            eval(p);
            p=['Path_' num2str(i) '_' num2str(j) '=Path'];
            eval(p);
            p=['E_' num2str(i) '_' num2str(j) '=E'];
            eval(p);
        end
end

NDper_Interaction_strength=[];
NDper_Hamming_dist=[];
NDper_Cosine_dist=[];
NDper_nbld=[];
for count=1:NOP
    %%Randmization of the dataset
    I=randperm(NP*NS);
    [row,col]=ind2sub([NP,NS],I);
    X=reshape(row,NP,NS);
    Y=reshape(col,NP,NS);
    d1_Interaction_strength=[]; d1_Hamming_dist=[]; d1_Cosine_dist=[]; d1_nbld=[];
    d2_Interaction_strength=[]; d2_Hamming_dist=[]; d2_Cosine_dist=[]; d2_nbld=[];

%%Within Participants
for i=1:NS
    for j=1:NP
        load(['J_L_' num2str(X(i,j)) '_' num2str(Y(i,j)) '.mat']);
        J_1=J;
        for k=(j+1):NP
            load(['J_L_' num2str(X(i,k)) '_' num2str(Y(i,k)) '.mat']);
            J_2=J;
            d=abs(J_1-J_2);
            d1_Interaction_strength=[d1_Interaction_strength,mean(d(:))];
            p=['d1_Hamming_dist=[d1_Hamming_dist,Hamming_Distance(nodeNum,index_' num2str(X(i,j)) '_' num2str(Y(i,j)) ',index_' num2str(X(i,k)) '_' num2str(Y(i,k)) ')];'];
            eval(p);
            p=['d1_Cosine_dist=[d1_Cosine_dist,Cosine_distance(nodeNum,BasinGraph_' num2str(X(i,j)) '_' num2str(Y(i,j)) ',BasinGraph_' num2str(X(i,k)) '_' num2str(Y(i,k)) ',index_' num2str(X(i,j)) '_' num2str(Y(i,j)) ',index_' num2str(X(i,k)) '_' num2str(Y(i,k)) ')];'];
            eval(p);
            p=['d1_nbld=[d1_nbld, abs(tbl_' num2str(X(i,j)) '_' num2str(Y(i,j)) '-tbl_' num2str(X(i,k)) '_' num2str(Y(i,k)) ')/max(tbl_' num2str(X(i,j)) '_' num2str(Y(i,j)) ',tbl_' num2str(X(i,k)) '_' num2str(Y(i,k)) ')];'];
            eval(p);
        end
    end
end

%%Between Participants
for i=1:NS
    for j=1:NP
        load(['J_L_' num2str(X(j,i)) '_' num2str(Y(j,i)) '.mat']);
        J_1=J;
        for k=(j+1):NP
            load(['J_L_' num2str(X(k,i)) '_' num2str(Y(k,i)) '.mat']);
            J_2=J;
            d=abs(J_1-J_2);
            d2_Interaction_strength=[d2_Interaction_strength,mean(d(:))];
            p=['d2_Hamming_dist=[d2_Hamming_dist,Hamming_Distance(nodeNum,index_' num2str(X(j,i)) '_' num2str(Y(j,i)) ',index_' num2str(X(k,i)) '_' num2str(Y(k,i)) ')];'];
            eval(p);
            p=['d2_Cosine_dist=[d2_Cosine_dist,Cosine_distance(nodeNum,BasinGraph_' num2str(X(j,i)) '_' num2str(Y(j,i)) ',BasinGraph_' num2str(X(k,i)) '_' num2str(Y(k,i)) ',index_' num2str(X(j,i)) '_' num2str(Y(j,i)) ',index_' num2str(X(k,i)) '_' num2str(Y(k,i)) ')];'];
            eval(p);
            p=['d2_nbld=[d2_nbld, abs(tbl_' num2str(X(j,i)) '_' num2str(Y(j,i)) '-tbl_' num2str(X(k,i)) '_' num2str(Y(k,i)) ')/max(tbl_' num2str(X(j,i)) '_' num2str(Y(j,i)) ',tbl_' num2str(X(k,i)) '_' num2str(Y(k,i)) ')];'];
            eval(p);
        end
    end
end
    d1_Interaction_strength=mean(d1_Interaction_strength);
    d1_Hamming_dist=mean(d1_Hamming_dist);
    d1_Cosine_dist=mean(d1_Cosine_dist);
    d1_nbld=mean(d1_nbld);

    d2_Interaction_strength=mean(d2_Interaction_strength);
    d2_Hamming_dist=mean(d2_Hamming_dist);
    d2_Cosine_dist=mean(d2_Cosine_dist);
    d2_nbld=mean(d2_nbld);
        
        NDper_Interaction_strength=[NDper_Interaction_strength;d2_Interaction_strength./d1_Interaction_strength];
        NDper_Hamming_dist=[NDper_Hamming_dist;d2_Hamming_dist./d1_Hamming_dist];
        NDper_Cosine_dist=[NDper_Cosine_dist;d2_Cosine_dist./d1_Cosine_dist];
        NDper_nbld=[NDper_nbld;d2_nbld./d1_nbld];
end
p_values=[find(ND_Interaction_strength>=NDper_Interaction_strength)/NOP,find(ND_Hamming_dist>=NDper_Hamming_dist)/NOP,find(ND_Cosine_dist>=NDper_Cosine_dist)/NOP,find(ND_nbld>=NDper_nbld)/NOP];
save permutation_results.mat NDper_Interaction_strength NDper_Hamming_dist NDper_Cosine_dist NDper_nbld p_values