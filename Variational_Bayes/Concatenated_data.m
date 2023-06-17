clear all
nodeNum=7;      %No of ROIs
tmax=1000;         %maximum time points in one dataset
participants=['1','2'];     %Participants name/index
sessions=['1','2'];         %session id
binarizedData=[];
for i=1:length(participants)
        for j=1:length(sessions)
            binarizedData_all=importdata(['SampleData_Binarized_Participant_' participants(i) '_Session_' sessions(j) '.mat']);
            binarizedData_all(binarizedData_all==-1)=0;
            binarizedData=[binarizedData;binarizedData_all'];
        end
end
save Binarized_sample_data.mat binarizedData