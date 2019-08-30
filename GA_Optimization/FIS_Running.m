% Evaluating the FIS's performance on a dataset in terms of RMSE
%% Loading FIS and the dataset to be put through FIS
FIS_Model_Name = input('Enter the FIS name: ','s');
fuzinfsys = readfis(FIS_Model_Name);

SetOfSamples_File=input('Enter the dataset file/variable name: ','s');
disp('Loading the dataset to be put through FIS...')
try 
    SetOfSamples=load(SetOfSamples_File);       
catch ME
    try
        SetOfSamples=evalin('base',SetOfSamples_File);
    catch ME
        error('The variable/file does not exist!')
    end
end
disp('The loading is finished.')

attrord=str2num(input('If necessary, rearrange the attribute order: ','s'));
Buf_SetOfSamples = SetOfSamples;
for i=1:1:size(SetOfSamples,2)
    Buf_SetOfSamples(:,i)=SetOfSamples(:,attrord(i));
end
SetOfSamples = Buf_SetOfSamples;

%% Performing fuzzy inference
disp('Fuzzy inference is performed...')
Yes_No_Out=evalfis([SetOfSamples(:,1:1:length(fuzinfsys.input))],fuzinfsys);
Result= [SetOfSamples(:,length(fuzinfsys.input)+1),Yes_No_Out];
disp('  ');
disp('------');
disp('Fuzzy inference results:')
disp(['FIS: ' FIS_Model_Name]);
disp(['Total number of outputs: '  num2str(size(Result,1))]);
disp(['RMSE: ',num2str(rmse(Result(:,1),Result(:,2)),10)]);
disp('------');