%% Notes before you run this script
% - Store all the SWMM model, SWMM engine files, FLC script and Test
%   scripts etc in one folder
% - each SWMM outfall must connect to orifice
% - SWMM output differences before and after RTC simulation
% - the best way is to use multiple controllers to multile orifices for system-level control
%% Initialize SWMM if you 
inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/noGI_Control.INP';
%inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/noGI_Control, Chicago_12h_1yr.INP';
%inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/noGI_Control, Chicago_12h_2yr.INP';
%inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/noGI_Control, Chicago_12h_5yr.INP';
%inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/noGI_Control, Chicago_12h_10yr.INP';
%inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/noGI_Control, Chicago_12h_25yr.INP';
%inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/noGI_Control, Chicago_12h_50yr.INP';
%inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/noGI_Control, Chicago_12h_100yr.INP';
%inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/noGI_Control, Chicago_12h_200yr.INP';
%inp = 'C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/swmm_files/Sugar House Master Plan 4.10.18  all storm events.INP';
%% Load the SWMM library
swmm = SWMM;
plot_response = 1;
save_plot     = 0;
%% Running a SWMM simulation
%[e, d] = swmm.run_simulation(inp); % e: vector of errors such as e(1) run-off | e(2) flow rounting | e(3) water quality; d: duration in seconds of simulation
%% Call FLC and defuzzied output  
fis = readfis('C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/RBC_Fuzzy_20190709_optimized')
%fis = readfis('C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/RBC_Fuzzy_20190707_optimized')
%fis = readfis('C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/SH_FLC_Multi output_10162018')
%fis = readfis('C:/Users/Jiada/Desktop/MatSWMM/MatSWMM/MatSWMM 5.1.009/Matlab module/SWMM Matlab/RBC_FLC_20181102_optimized')
%% Initialize parameter
swmm.initialize(inp);
%i = 1;·
dt = 1/120; % need double check
t = [0:1/12:48]'; % Need doble check
n_tsteps = ceil( t(end)/dt ); %Need double check
%n_tsteps ;
n_tsteps = length(t);
depth_swmm   = zeros(n_tsteps,1); %
level_swmm    = zeros(n_tsteps,1);
flow_swmm = zeros(n_tsteps,1);%
setting_swmm = zeros(n_tsteps,1); %
time = zeros(n_tsteps,1);
input = zeros(n_tsteps,3);
output = zeros(n_tsteps,3);
%% Define function handles
remove_blanks = @(array) array(~ismember(array,{'','(null)'}));
%% Store the SWMM elements in list
% storages = swmm.get_all(inp,swmm.STORAGE,swmm.NONE);% Store the storage info in the 'junctions' list
junctions = remove_blanks(swmm.get_all(inp,swmm.JUNCTION,swmm.NONE)); % Store the junction info in the 'junctions' list
conduits = remove_blanks(swmm.get_all(inp,swmm.LINK,swmm.NONE)); % Store the link info in the 'conduits' list
orifices = remove_blanks(swmm.get_all(inp,swmm.ORIFICE,swmm.NONE)); % Store the orifice info in the 'orifices' list
subcatch = remove_blanks(swmm.get_all(inp,swmm.SUBCATCH,swmm.NONE)); % Store the subcatch info in the 'subcatch' list
%% IMPORT THE CONTROL OUTPUT INTO ORIFICE  OF SWMM-loop
n_tsteps  = 1
 while ~swmm.is_over 
     % Define the step time  
     time(n_tsteps) = swmm.run_step; 
     % Get the simulated inputs:Upstream water level, rainfall, and downstream
     % water depth data
     %level_swmm(n_tsteps,1)  = swmm.step_get('240',swmm.DEPTH,swmm.SI); % select unit (SI or EI)
     %depth_swmm(n_tsteps,1) = swmm.step_get('110',swmm.DEPTH,swmm.SI); % select unit (SI or EI)
     %rainfall_swmm(n_tsteps,1) = swmm.step_get('SC54',swmm.PRECIPITATION,swmm.SI); % select unit (SI or EI)
     
     level_swmm(n_tsteps,1)  = swmm.step_get('90',swmm.DEPTH,swmm.SI); % select unit (SI or EI)
     flow_swmm(n_tsteps,1) = swmm.step_get('40',swmm.FLOW,swmm.SI); % select unit (SI or EI)
     setting_swmm(n_tsteps,1) = swmm.step_get('CP',swmm.SETTING,swmm.SI); 
     %depth_swmm(n_tsteps,1) = swmm.step_get('91',swmm.I,swmm.SI); % select unit (SI or EI)
     %rainfall_swmm(n_tsteps,1) = swmm.step_get('30',swmm.PRECIPITATION,swmm.SI); % select unit (SI or EI)
     
     % input for FIS(only three inputs so far, we need multipe timeseries inputs for different variables?)
     %input(n_tsteps,1:3) = [level_swmm(n_tsteps,1),rainfall_swmm(n_tsteps,1),depth_swmm(n_tsteps,1)];
     %input(n_tsteps,1) = [level_swmm(n_tsteps,1)];
     input(n_tsteps,1:2) = [level_swmm(n_tsteps,1),flow_swmm(n_tsteps,1)];
      
     % USE 'evalfis' function to get the FLC output(only one output?, we need multiple time-series setting outputs) 
     % output(n_tsteps,1) = evalfis(fis,input(n_tsteps,1:3));
     output(n_tsteps,1) = evalfis(fis,input(n_tsteps,1));
     
     %Implement FLC output for orifice setting
     swmm.modify_setting('CP',output(n_tsteps,1));
     %swmm.modify_setting('Wilson',output(n_tsteps,1));
     
     %%Note: swmm.modify_setting(orifices,output(1,:)),here only one controller have been used to one orifices, you can use one same FLC controller to adjust multiple orfices. 
     %Or, use multiple different FLC controllers to adjust multile orifice setting at
     %system-level scale RTC. Here below is an example to use multiple
     %different controllers to adjust multiple orifice settings:
     
     %Firstly, run 'evalfis' function separately for each output, e.g.:
     %output1(n_tsteps,1) = evalfis(fis,input1);
     %output2(n_tsteps,1) = evalfis(fis,input2); 
     %output3(n_tsteps,1) = evalfis(fis,input3);
     
     % and then,do
     % controller1 swmm.modify_setting('orifice1',output1(n_tsteps,1));
     % controller2 swmm.modify_setting('Orifice2',output2(n_tsteps,1));
     % controller3 swmm.modify_setting('Orifice3',output3(n_tsteps,1));
       
     n_tsteps = n_tsteps +1;
     %swmm.end_sim()
 end    
 [e d] = swmm.finish
%% Retrive specific object information
% read results for controller inputs of 2 varaibles 
[t, J_Level_90] = swmm.read_results('90', swmm.NODE, swmm.DEPTH);
%[t, J_Inflow_91] = swmm.read_results('91', swmm.NODE, swmm.INFLOW);
[t, L_Flow_40] = swmm.read_results('40', swmm.LINK, swmm.FLOW);

% read results for flooded tank unit '93'
[t, J_Flood_93] = swmm.read_results('93', swmm.NODE, swmm.FLOODING);
[t, J_Level_93] = swmm.read_results('90', swmm.NODE, swmm.DEPTH);

%[t, J_Level_90] = swmm.read_results('240', swmm.NODE, swmm.DEPTH);
%[t, J_Depth_91] = swmm.read_results('110', swmm.NODE, swmm.DEPTH);
%[t, S_Rain_30] = swmm.read_results('SC54', swmm.SUBCATCH, swmm.PRECIPITATION);

%read  results for oririce's flow and setting
[t, OR_FlOW_CP] = swmm.read_results('38', swmm.LINK, swmm.FLOW);
[t, OR_Depth_CP] = swmm.read_results('38', swmm.LINK, swmm.DEPTH);

%[t, OR_Setting_CP] = swmm.read_results('Wilson', swmm.LINK, swmm.SETTING);
%[t, OR_Flow_CP] = swmm.read_results('Wilson', swmm.LINK, swmm.FLOW);

%read results for subcatchment '30' runoff
%[t, S_Runoff_30] = swmm.read_results('30', swmm.SUBCATCH, swmm.PRECIPITATION);
%[t, S_Runoff_30] = swmm.read_results('SC54', swmm.SUBCATCH, swmm.PRECIPITATION);

%read results for water level of storage tank if possible
%[t, T_WL_ID] = swmm.read_results('Tank ID', swmm.STORAGHE, swmm.DEPTH);

% print the current simulation time; current_time = swmm_get_time()
%fprintf('current_step = %.3f s\n',time(step,:));

% print the time-series FLC inputs for two varaibles : dwonstream flow and downstream water depth
fprintf('J_Level_90 = %.3f ft\n',[t, J_Level_90]);
%fprintf('J_Inflow_91 = %.3f m\n',[t, J_Inflow_91]);
fprintf('L_Flow_40 = %.3f cfs\n',[t, L_Flow_40]);

%Print time-series Orifice flow and settings
%fprintf('OR_Flow_CP = %.3f m\n',[t, OR_Flow_CP]);
%fprintf('OR_Depth_CP = %.3f m\n',[t, OR_Depth_CP]); 

%Print water level of tank unit '93'
fprintf('J_Level_93 = %.3f ft\n',[t, J_Level_90]);
%Print flooding volume of tank unit '93'
fprintf('J_Flood_93 = %.3f ft3\n',[t, J_Flood_93]);
    
%Print node total flooding volume
%fprintf('Total Flooding = %.3f m\n', swmm.total_flooding);

%% Retrive all object information  
%[t, tmp_runoff] = swmm.read_results(subcatch,swmm.SUBCATCH,swmm.RUNOFF); % select unit (SI or EI)
[~, tmp_flood ] = swmm.read_results(junctions,swmm.NODE,swmm.FLOODING); % select unit (SI or EI)
[~, tmp_precip] = swmm.read_results(subcatch,swmm.SUBCATCH,swmm.PRECIPITATION); % select unit (SI or EI)
%[~, tmp_depth] = swmm.read_results(junctions,swmm.NODE,swmm.DEPTH);
%select unit
%[~, tmp_flow ] = swmm.read_results(orifices,swmm.LINK,swmm.FLOW); %select unit (SI or EI
%[~, flood ] = swmm.read_results(storages,swmm.NODE,swmm.FLOODING); %select unit (SI or EI
%% Make plots
if plot_response
    f = figure('units','normalized','outerposition',[0 0 1 1]); %figure;
   
    %Plot system precipitation 
    ax(1) = subplot(6,1,1);
    bar(t(:,1),tmp_precip(:,1));
    set(ax(1),'Ydir','reverse');
    title('Rainfall Pattern ');
    ylabel('Precipitation /in');
    xlabel('Time /hr');
    
    %Plot node 903' water depth
    ax(2) = subplot(6,1,2);
    plot(t(:,1),J_Level_90,'m-.');
    title('Water Depth in Upstream Node 90');
    ylabel('Water Depth/ft');
    xlabel('Time /hr');
    
    %Plot link '40' flow
    ax(3) = subplot(6,1,3);
    plot(t(:,1),L_Flow_40,'m-.');
    title('Flow in Downstream Conduit 40');
    ylabel('Flow /cfs');
    xlabel('Time /hr');
    
    %Plot tank unit '93' water level      
    ax(4) = subplot(6,1,4);
    plot(t(:,1),J_Level_93,'m-.');
    title('Water Level in tank unit 93');
    ylabel('Water Level/ft');
    xlabel('Time /hr');
    
    %Plot tank unit '93' flooding volume
    ax(5) = subplot(6,1,5);
    plot(t(:,1),J_Flood_93,'m-.');
    title('Flooding Volume in tank unit 93');
    ylabel('Flooding /ft3');
    xlabel('Time /hr');
    
    %Plot system total flooding  volume
    %ax(6) = subplot(6,1,6);
    %bar(t(:,1),tmp_flood(:,1));
    %set(ax(6),'Ydir','reverse');
    %title('Systme Total Flooding Volume');
    %ylabel('Flooding /ft3');
    %xlabel('Time /hr')
     
   if save_plot
        
    end
 end
     
  disp('Data-driven SWMM_FLC is awesome!');


