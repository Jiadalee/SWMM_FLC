% Creating a random subset of the initial dataset

clear SampleNum;
clear SetOfSamples;
%% Loading a dataset...
Data_Set_File=input('Enter the initial dataset file/variable name: ','s');
disp('Loading the initial dataset...')
try 
    Data_Set=load(Data_Set_File);       
catch ME
    try
        Data_Set=evalin('base',Data_Set_File); % новое проверить
    catch ME
        error('The variable/file does not exist!')
    end
end
disp('The loading is finished.')

%% Getting the size of the dataset...
Data_Get_Size=size(Data_Set);
disp('--------------------');
disp(['The number of attributes: ', num2str(Data_Get_Size(2))]);
disp(['The number of records: ', num2str(Data_Get_Size(1))]);
disp('--------------------');

%% Defining the required sequence of attributes...
%NOTE: A single consequent is to be at the end of the array

attrord=str2num(input('Specify the attribute order: ','s'));
Buf_Data_Set = Data_Set;
for i=1:1:Data_Get_Size(2)
    Buf_Data_Set(:,i)=Data_Set(:,attrord(i));
end
Data_Set = Buf_Data_Set;

%% Creating a random subset of the dataset...
% NOTE: A random subset is in the <SetOfSamples> variable

NumberOfSamples=str2num(input('Enter the number of records: ','s'));
% NOTE: If the whole dataset is to be used to form a random subset, enter '-1' 

if NumberOfSamples == -1 
    NumberOfSamples=Data_Get_Size(1);
end

SampleNum = randperm(Data_Get_Size(1),NumberOfSamples)'; 
SetOfSamples = zeros(NumberOfSamples,Data_Get_Size(2)); 
for i=1:1:NumberOfSamples
    SetOfSamples(i,:)=Data_Set(SampleNum(i),:);
end 

SetOfSamples_File = input('Enter the random subset file name: ','s');
dlmwrite([SetOfSamples_File,'.txt'],SetOfSamples);
    