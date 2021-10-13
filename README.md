# A simple example of reproducible building energy simulation

[![Launch RStudio Cloud](https://img.shields.io/badge/RStudio-Cloud-blue)](https://rstudio.cloud/project/2306579)
[![Docker Build Status](https://img.shields.io/docker/cloud/automated/hongyuanjia/reproducing-building-simulation.svg)](https://hub.docker.com/r/hongyuanjia/reproducing-building-simulation)

This repository contains a simple example demonstrating the use of Docker containers to reproduce the calibration
of a building energy simulation model.

More details can be found in Section 6.3 of [our paper](https://github.com/ideas-lab-nus/calibrating-building-simulation-review):

> Adrian Chong, Yaonan Gu and Hongyuan Jia, (2021).
> *Calibrating building energy simulation models: A review of the basics to guide future work*.
> Energy and Buildings, 111533. doi: <https://doi.org/10.1016/j.enbuild.2021.111533>


## Citation

Please cite this compendium as:
```
@article{chong2021calibrating,
  title={Calibrating building energy simulation models: A review of the basics to guide future work},
  author={Chong, Adrian and Gu, Yaonan and Jia, Hongyuan},
  journal={Energy and Buildings},
  pages={111533},
  year={2021},
  doi={https://doi.org/10.1016/j.enbuild.2021.111533},
  publisher={Elsevier}
}
```


## How to access

There are several ways to try out this example:

1. Using the [Docker image](https://hub.docker.com/r/hongyuanjia/reproducing-building-simulation).

2. Using the [RStudio Cloud](https://rstudio.cloud/project/2306579) instance.

3. Clone or download this repository and install the required R packages by calling `renv::restore()`.

## File structure

The main files are:

```
.
├── renv.lock
├── R
│   └── functions.R
├── data-raw
│   ├── epw
│   │   └── ...
│   └── idf
│       └── ...
├── analysis
│   ├── workflow-synthetic.Rmd
│   └── workflow-calibrate.Rmd
├── data
│   ├── idf
│   │   └── ...
│   └── sim
│       └── ...
├── figures
│   └── ...
└── report
    ├── workflow-synthetic.html
    └── workflow-calibrate.html
```

| File                                                                                                                                            | Purpose                                                                                                                                                                                                                                |
| ---                                                                                                                                             | ---                                                                                                                                                                                                                                    |
| [`renv.lock`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/renv.lock)                                             | The [renv](https://rstudio.github.io/renv/index.html) lockfile, describing the state of libraries used in this projected.                                                                                                              |
| [`R/*.R`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/R)                                                         | R scripts with helper functions for model modification, simulation output extraction, optimization and results visualization.                                                                                                          |
| [`data-raw/idf/*.idf`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/data/idf)                                     | The uncalibrated example [EnergyPlus](https://energyplus.net/) model.                                                                                                                                                                  |
| [`data-raw/epw/*/*.epw`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/data/epw)                                   | The TMY3 (Typical meteorological year) and AMY(Actual Meteorological Year) EnergyPlus weather file.                                                                                                                                    |
| [`analysis/workflow-synthetic.Rmd`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-synthetic.Rmd) | The [R Markdown](https://rmarkdown.rstudio.com/) file which documents the synthetic data creation workflow.                                                                                                                            |
| [`analysis/workflow-calibrate.Rmd`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-calibrate.Rmd) | The [R Markdown](https://rmarkdown.rstudio.com/) file which documents the model calibration workflow.                                                                                                                                  |
| [`data/idf/`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/master/data/idf)                                            | The processed model generated during the calibration workflow.                                                                                                                                                                         |
| [`data/sim/`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/master/data/sim)                                            | The simulation result summary for each processed model.                                                                                                                                                                                |
| [`figures/`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/master/figures)                                              | Plots generated during the calibration process, including one line plot per simulation comparing the synthetic meter data and simulation data.                                                                                         |
| [`report/workfow-calibrate.html`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-synthetic.html)  | The rendered [`workflow-synthetic.Rmd`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-synthetic.Rmd) in HTML format. You can preview it [here](https://workflow-synthetic.netlify.app). |
| [`report/workfow-calibrate.html`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-calibrate.html)  | The rendered [`workflow-calibrate.Rmd`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-calibrate.Rmd) in HTML format. You can preview it [here](https://workflow-calibrate.netlify.app). |

## Licenses

**Code :** [MIT](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/LICENSE) license

**Data :** [CC-0](http://creativecommons.org/publicdomain/zero/1.0/) attribution requested in reuse
