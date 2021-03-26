# An example of reproducible building energy model calibration

[![Launch RStudio Cloud](https://img.shields.io/badge/RStudio-Cloud-blue)](https://rstudio.cloud/project/2306579)

This repository is an example of reproducible building energy model calibration
workflow.

More details can be found in [our paper]():

> Adrian Chong, Yaonan Gu and Hongyuan Jia, (2021).
> *Calibrating building energy simulation models: A review of methods, inputs and outputs*.
> *In Review*. <https://doi.org/xxx/xxx>

## How to access

You can try out this example project as long as you have a browser and an
internet connection. [Click here](https://rstudio.cloud/project/2306579) to
navigate your browser to an RStudio Cloud instance. Alternatively, you can clone
or download this code repository and install the required R packages by calling
`renv::restore()`.

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

| File                                                                                                                                            | Purpose                                                                                                                                                             |
| ---                                                                                                                                             | ---                                                                                                                                                                 |
| [`renv.lock`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/renv.lock)                                             | The [renv](https://rstudio.github.io/renv/index.html) lockfile, describing the state of libraries used in this projected.                                           |
| [`R/functions.R`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/R/functions.R)                                     | An R script with helper functions.                                                                                                                                  |
| [`data-raw/idf/*.idf`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/data/idf)                                     | The uncalibrated example [EnergyPlus](https://energyplus.net/) model.                                                                                               |
| [`data-raw/epw/*/*.epw`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/data/epw)                                   | The TMY3 (Typical meteorological year) and AMY(Actual Meteorological Year) EnergyPlus weather file.                                                                 |
| [`analysis/workflow-synthetic.Rmd`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-synthetic.Rmd) | The [R Markdown](https://rmarkdown.rstudio.com/) file which documents the synthetic data creation workflow.                                                         |
| [`analysis/workflow-calibrate.Rmd`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-calibrate.Rmd) | The [R Markdown](https://rmarkdown.rstudio.com/) file which documents the model calibration workflow.                                                               |
| [`data/idf/`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/master/data/idf)                                            | The processed model generated during the calibration workflow.                                                                                                      |
| [`data/sim/`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/master/data/sim)                                            | The simulation result summary for each processed model.                                                                                                             |
| [`figures/`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/master/figures)                                              | Plots generated during the calibration process, including one line plot per simulation comparing the synthetic meter data and simulation data.                      |
| [`report/workfow-calibrate.html`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-synthetic.html)  | The rendered [`workflow-synthetic.Rmd`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-synthetic.Rmd) in HTML format. |
| [`report/workfow-calibrate.html`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-calibrate.html)  | The rendered [`workflow-calibrate.Rmd`](https://github.com/ideas-lab-nus/reproducing-building-simulation/blob/main/analysis/workflow-calibrate.Rmd) in HTML format. |
