# wio

R package to support [workflowr.io](https://github.com/workflowr/workflowr.io)

## Installation

Install and activate the conda environment:

```sh
mamba env create --file environment.yml
conda activate wior
```

Install wio:

```R
devtools::install_github("rstudio/webshot2", upgrade = FALSE)
devtools::install(dependencies = FALSE, upgrade = FALSE)
```
