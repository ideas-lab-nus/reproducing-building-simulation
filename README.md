# An example of reproducible building energy model calibration

[![Launch RStudio Cloud](https://img.shields.io/badge/RStudio-Cloud-blue)](https://rstudio.cloud/project/2306579)

This repository is an example of reproducible building energy model calibration
workflow.

More details can be found in [our paper]():

> Adrian Chong, Yaonan Gu and Hongyuan Jia, (2021).
> *Calibrating building energy simulation models: A review of modeling methods
> and data requirements*.
>  Renewable & Sustainable Energy Reviews <https://doi.org/xxx/xxx>

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
├── data
│   ├── idf
│   │   └── ...
│   └── sim
│       └── ...
├── analysis
│   └── workflow.Rmd
└── report
    └── workflow.html
```

| File                                                                                                                     | Purpose                                                                                                                                      |
| ---                                                                                                                      | ---                                                                                                                                          |
| [`renv.lock`](https://github.com/ideas-lab-nus/reproducible-BEM-calibration/blob/main/renv.lock)                         | The [renv](https://rstudio.github.io/renv/index.html) lockfile, describing the state of libraries used in this projected.                    |
| [`analysis/workflow.Rmd`](https://github.com/ideas-lab-nus/reproducible-BEM-calibration/blob/main/analysis/workflow.Rmd) | The [R Markdown](https://rmarkdown.rstudio.com/) file which documents the whole calibration workflow.                                        |
| [`report/workfow.html`](https://github.com/ideas-lab-nus/reproducible-BEM-calibration/blob/main/analysis/workflow.html)  | The rendered [`workflow.Rmd`](https://github.com/ideas-lab-nus/reproducible-BEM-calibration/blob/main/analysis/workflow.Rmd) in HTML format. |
| [`R/functions.R`](https://github.com/ideas-lab-nus/reproducible-BEM-calibration/blob/main/R/functions.R)                 | An R script with helper functions.                                                                                                           |
| [`data-raw/idf/*.idf`](https://github.com/ideas-lab-nus/reproducible-BEM-calibration/blob/main/data/idf)                 | The uncalibrated example [EnergyPlus](https://energyplus.net/) model.                                                                        |
| [`data-raw/epw/*/*.epw`](https://github.com/ideas-lab-nus/reproducible-BEM-calibration/blob/main/data/epw)               | The [IWEC](https://energyplus.net/weather/sources#IWEC) and AMY(Actual Meteorological Year) EnergyPlus weather file.                         |
| [`data/idf/`](https://github.com/ideas-lab-nus/reproducible-BEM-calibration/blob/master/data/idf)                        | The processed model generated during the calibration workflow.                                                                               |
| [`data/sim/`](https://github.com/ideas-lab-nus/reproducible-BEM-calibration/blob/master/data/sim)                        | The simulation result summary for each processed model.                                                                                      |
