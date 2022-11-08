# wio

R package to support [workflowr.io](https://github.com/workflowr/workflowr.io)

## Installation

Install and activate the conda environment:

```sh
mamba env create --file environment.yml
conda activate wior
```

Install wio (and any other deps not available as conda binaries):

```R
# Have to install dev version of rcrossref to handle update in crossref API
# related to UTF-8
remotes::install_github("ropensci/rcrossref", dependencies = FALSE, upgrade = FALSE)

devtools::install(dependencies = FALSE, upgrade = FALSE)
```
