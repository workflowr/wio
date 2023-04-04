# wio

R package to support [workflowr.io](https://github.com/workflowr/workflowr.io)

## Installation

Install and activate the conda environment:

```sh
mamba env create --file environment.yml
conda activate wior
```

Install wio:

```sh
R CMD INSTALL --build .
```

## Troubleshooting

If you run into installation or runtime errors, first try the lockfile to
install the exact same versions of all the dependencies. Note that the syntax to
create a conda environment from a lockfile is different from above

```sh
mamba create --name wior-lock --file environment.lock.yml
conda activate wior-lock
R CMD INSTALL --build .
```

The lockfile was created with the following:

```sh
conda activate wior
conda list --explicit > environment.lock.yml
```
