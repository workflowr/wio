# wio

R package to support [workflowr.io](https://github.com/workflowr/workflowr.io)

## Installation

Install and activate the conda environment:

```sh
mamba env create --file environment.yml
conda activate wior
```

Install [ghapps](https://github.com/jeroen/ghapps) and wio:

```R
remotes::install_github("jeroen/ghapps", dependencies = FALSE, upgrade = FALSE)
devtools::install(dependencies = FALSE, upgrade = FALSE)
```

Note: ghapps doesn't have a tag yet, so I haven't created a conda binary for it yet.
