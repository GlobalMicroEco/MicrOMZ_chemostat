# MicrOMZ_chemostat 
MicrOMZ is a trait-based functional type mode that simulates the growth, mortality, and grazing of chemoautotrophic and heterotrophic bacteria functional type populations (see Zakem et al., 2019, 2022).

By modeling the metabolisms of these bacterial populations, we are able to resolve the key nitrogen cycle reactions of nitrification, denitrification, and anammox using Tilman resource competition arguments, rather than parameterizing the reactions as a function of seawater chemistry only (e.g., 'NitrOMZ' from Bianchi et al., 2022).

The model is embedded here in a 0-D chemostat with constant dilution rate (D). 

Contact Daniel McCoy (dmccoy@carnegiescience.edu) for assistance.
    
## Table of Contents

- [Updates](#updates)
- [Getting started](#getting-started)
- [Code structure](#code-structure)
- [Support](#support)
- [How to cite](#how-to-cite)

Requires MATLAB 2013 or above.

## Updates
* 12/04/2025 -- First commit of MicrOMZ_chemostat 

## Getting started
#### Set run options via 'options.m'
    Set model options for variable organic matter input:
        amplitude == amplitude of organic matter oscillations
        period    == period of oscillations
    Also turn on/off tracers and functional types
        
#### Run the model 
    model = run_model

## Code structure 
    options.m             -- Script to toggle main model settings
    run_model.m           -- Call this to run the model ('>> run_model')
                   
#### functions/
    Folder where functions are stored, mostly for plotting 

#### src
    Folder where core model functions are stored
        init_model    == Initializes model based on options.m
        timestepping  == Module that runs model forward in time, saving each timestep
        sources_sinks == Function called in 'timestepping.m' that calculate biogeochemical sources/sinks
        calc_rstar    == Function that calculates Tilman's R* for each functional type
        ftype_params  == Where functional type parameters live

#### plotting/ 
    Folder where some useful plotting functions for MicrOMZ output are stored
        make_plots == Generates model spinup figures for each tracer
        make_zngi  == Generates 'zero-net-growth-isolines' for oxidant/reductant pairs

#### output/
    Folder to store output
      
## Support
Contact Daniel McCoy at the Carnegie Institution for Science (dmccoy@carnegiescience.edu) 

