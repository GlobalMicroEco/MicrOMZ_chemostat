# MicrOMZ_chemostat 
MicrOMZ is a trait-based functional type mode that simulates the growth, mortality, and grazing of chemoautotrophic and heterotrophic bacteria functional type populations (see Zakem et al., 2019, 2022).

By modeling the metabolisms of these bacterial populations, we are able to resolve the key nitrogen cycle reactions of nitrification, denitrification, and anammox using Tilman resource competition arguments, rather than parameterizing the reactions as a function of seawater chemistry only (e.g., 'NitrOMZ' from Bianchi et al., 2022).

The model is embedded here in a 0-D chemostat with constant dilution rate ($D$). 

Contact Daniel McCoy (dmccoy@carnegiescience.edu) for assistance.
    
## Table of Contents

- [Updates](#updates)
- [Model Description](#description)
- [Getting started](#getting-started)
- [Code structure](#code-structure)
- [Support](#support)
- [How to cite](#how-to-cite)

Requires MATLAB 2013 or above.

## Updates
* 12/04/2025 -- First commit of MicrOMZ_chemostat 

## Model Description

MicrOMZ_chemostat models microbial functional types competing for oxidants and reductants in a well-mixed chemostat with constant dilution rate ($D$) ($\mathrm{d}^{-1}$). Each microbial type $i$
- consumes one or more substrates (e.g., OM, $\mathrm{NO}_3^-$, $\mathrm{NO}_2^-$, $\mathrm{NH}_4^+$, $\mathrm{O}_2$, $\mathrm{N}_2\mathrm{O}$,
- produces metabolic byproducts determined by its redox pathway,
- experiences washout at rate ($D$),
- grows according to Liebig’s law of the minimum.

Functional types interact through substrate competition and metabolic cross-feeding. At ecological steady state, resource concentrations are set by the lowest subsistence threshold $R^*$ among competing populations (Tilman resource competition theory). All chemical tracers evolve through chemostat dilution, microbial uptake, and microbial byproduct formation.

---

### Model Equations

#### 1. Biomass dynamics

Microbial biomass $B_i$ (mmol $\mathrm{m}^{-3}$) evolves as:

$$
\frac{d B_i}{dt} = (\mu_i - D)\, B_i,
$$

where $\{mu}_i$ is the realized growth rate of type $i$. A population persists only when all required substrates exceed its subsistence threshold:

$$
R_j \ge R^*_{i,j}.
$$

Resource competition drives steady-state resource levels to the lowest $R^*$ imposed by any competitor.

---

#### 2. Growth limitation and Monod uptake
Microbial growth on resource $j$ follows:

$$
\mu_{ij}
= y_{ij}\, V^{\max}_{ij}\, \frac{R_j}{R_j + K_{ij}},
$$

where:

- $K_{ij}$ — half-saturation coefficient,  
- $V^{\max}_{ij}$ — maximum uptake rate (mol resource per mol biomass per day),  
- $y_{ij}$ — biomass yield (mol biomass per mol resource),  
- $R_j$ — environmental concentration of resource \(j\).

This results in a classical subsistence concentration:

$$
R^*_{i,j} = \frac{K_{ij} D}{y_{ij} V^{\max}_{ij} - D}.
$$

---

#### 3. Tracer dynamics

All dissolved tracers obey the standard chemostat mass balance:

- **Dilution:** $D([X]_{\text{in}} - [X])$ 
- **Microbial production:** $\sum_i e_{i,x}$, $mu_i$ $B_i$  
- **Microbial consumption:** $\sum_i \frac{1}{y_{i,x}}$, $mu_i B_i$

Tracer-specific equations follow.

##### Organic Matter (OM)

$$
\frac{\partial [\mathrm{OM}]}{\partial t}
= D([\mathrm{OM}]_{\text{in}} - [\mathrm{OM}]) 
- \sum_i \frac{1}{y_{i,om}}\, \mu_i B_i
$$

##### Nitrate (NO\(_3^-\))

$$
\frac{\partial [\mathrm{NO_3^-}]}{\partial t}
= D([\mathrm{NO_3^-}]_{\text{in}} - [\mathrm{NO_3^-}])
+ \sum_i e_{i,no3}\, \mu_i B_i
- \sum_i \frac{1}{y_{i,no3}}\, \mu_i B_i
$$

##### Nitrite (NO\(_2^-\))

$$
\frac{\partial [\mathrm{NO_2^-}]}{\partial t}
= D([\mathrm{NO_2^-}]_{\text{in}} - [\mathrm{NO_2^-}])
+ \sum_i e_{i,no2}\, \mu_i B_i
- \sum_i \frac{1}{y_{i,no2}}\, \mu_i B_i
$$

##### Ammonium (NH\(_4^+\))

$$
\frac{\partial [\mathrm{NH_4^+}]}{\partial t}
= D([\mathrm{NH_4^+}]_{\text{in}} - [\mathrm{NH_4^+}])
+ \sum_i e_{i,nh4}\, \mu_i B_i
- \sum_i \frac{1}{y_{i,nh4}}\, \mu_i B_i
$$

##### Dinitrogen (N\(_2\))

$$
\frac{\partial [\mathrm{N_2}]}{\partial t}
= D([\mathrm{N_2}]_{\text{in}} - [\mathrm{N_2}])
+ \sum_i e_{i,n2}\, \mu_i B_i
$$

##### Oxygen (O\(_2\))

$$
\frac{\partial [\mathrm{O_2}]}{\partial t}
= D([\mathrm{O_2}]_{\text{in}} - [\mathrm{O_2}])
- \sum_i \frac{1}{y_{i,o2}}\, \mu_i B_i
$$

##### Nitrous Oxide (N\(_2\)O)

$$
\frac{\partial [\mathrm{N_2O}]}{\partial t}
= D([\mathrm{N_2O}]_{\text{in}} - [\mathrm{N_2O}])
+ \sum_i e_{i,n2o}\, \mu_i B_i
- \sum_i \frac{1}{y_{i,n2o}}\, \mu_i B_i
$$

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

