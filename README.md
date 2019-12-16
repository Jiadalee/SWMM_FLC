# SWMM_FLC
SWMM_FLC is an optimization-simulation tool for Fuzzy Logic Control (FLC) by using Matlab Package and SWMM5 [EPASWMM5 Environmental Protection Agency Stormwater Management Model](https://www.epa.gov/water-research/storm-water-management-model-swmm).This tool can be used to co-simulate Fuzzy Logic Control(FLC) and hydraulic-hydrologic process with respect to rainfall-runoff model. SWMM_FLC needs the matlab module of [MatSWMM](https://github.com/networked-systems/MatSWMM) which can simultaneously step through the modeling of SWMM5 and operating the real-time controllers on Matlab.


# Optimization_simulation setting before running SWMM_FLC:

1) Setting 1: Before you train the fuzzy ‘controller’ for characterizing relationship between fuzzy system inputs and outputs, please store your training datasets in GA_Optimization folder;
2) Setting 2: Before you run genetic algorithm optimization for tuning parameters of membership functions, please put fuzzy logic inference system ‘.fis’ file , which you previously created in MATLAB, into GA_Optimization folder; 
3) Setting 3: Before you run ‘SWMM_FLC’ simulation, please put SWMM .inp file in the folder of ‘swmm_files’ of MATLAB module folder of FLC_Simulation, and also save the fuzzy inference system ’.fis’ file in the folder of MATLAB module folder of FLC_Simulation.
4) Current SWMM_FLC version can only be run on MATLAB 2018.


# Availability: 
The ‘SWMM_FLC’ tool must be run after set-up the required software and optimization-simulation settings above. The urban drainage system simulation model used is EPASWMM, which is available at https://www.epa.gov/water-research/storm-water-management-model-swmm. Data including flow and water level measurements, SWMM models, and optimal fuzzy inference system outputs;
