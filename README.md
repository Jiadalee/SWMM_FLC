# SWMM_FLC
SWMM_FLC is an optimization-simulation tool for Fuzzy Logic Control (FLC) by using Matlab Package and SWMM5 [EPASWMM5 Environmental Protection Agency Stormwater Management Model](https://www.epa.gov/water-research/storm-water-management-model-swmm).This tool can be used to co-simulate Fuzzy Logic Control(FLC) and hydraulic-hydrologic process with respect to rainfall-runoff model.  of  SWMM_FLC needs the matlab module of [MatSWMM](https://github.com/networked-systems/MatSWMM) which can simultaneously step through the modeling of SWMM5 and operating the real-time controllers on Matlab.


# Optimization_simulation set before run SWMM_FLC:

1) Before run genetic algorithm optimization for tuning parameters of membership functions, put fuzzy logic inference system ‘.fis’ file , which you previously created in MATLAB, into GA_Optimization folder; 
2) When you run ‘SWMM_FLC’ simulation, please put SWMM .inp file in the folder of ‘swmm_files’ of MATLAB module folder of FLC_Simulation, and also store the fuzzy inference system ’.fis’ file in the folder of ‘SWMM Matlab’ MATLAB module folder of FLC_Simulation.

# Availability: 
The ‘SWMM_FLC’ tool must be run after set-up the required software and optimization-simulation settings. The urban drainage system simulation model used is EPASWMM, which is available at https://www.epa.gov/ water-research/storm-water-management-model-swmm. Data including flow and water level measurements, SWMM models and optimal fuzzy logic outputs;
