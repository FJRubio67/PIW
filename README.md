# The Wasserstein Prior

## Overview

This repository contains the R code and numerical examples associated with:

> Li, W. and Rubio, F.J. (2022). On a prior based on the Wasserstein information
> matrix. *Statistics and Probability Letters* **190**: 109645.
> [DOI: 10.1016/j.spl.2022.109645](https://doi.org/10.1016/j.spl.2022.109645) |
> [arXiv:2202.03217](https://arxiv.org/abs/2202.03217)

The **Wasserstein prior** (PIW) is an objective prior for the parameters of
univariate continuous distributions, constructed using the
**Wasserstein information matrix**, an analogue of the classical Fisher
information matrix based on the $L^2$-Wasserstein metric. The prior is
**invariant under reparameterisations**, has connections to information geometry,
and produces posteriors with good frequentist properties as demonstrated through
simulation. The paper establishes sufficient conditions for posterior propriety
for general model classes, and illustrates the prior on the skew-normal
distribution and the normal linear regression model.

## Repository structure

```
PIW/
├── piwSN/               # Wasserstein prior for the skew-normal distribution
│   ├── piwSN.Rmd        # R Markdown source
│   ├── piwSN.html       # Rendered tutorial
│   └── references.bib
├── piwBMI/              # Application to BMI data (skew-normal model)
│   ├── piwBMI.Rmd       # R Markdown source: MLE, MCMC via Rtwalk,
│   │                    #   posterior summaries, predictive density plots
│   ├── piwBMI.html      # Rendered tutorial
│   └── references.bib
└── piwNLRM/             # Wasserstein prior for normal linear regression
    ├── piwNLRM.Rmd      # R Markdown source
    ├── piwNLRM.html     # Rendered tutorial
    └── references.bib
```

## Requirements

The following R packages are required:

```r
install.packages(c("sn", "Rtwalk", "coda", "ggplot2"))
```

> Verify exact dependencies against the `library()` calls at the top of each
> `.Rmd` file, as the list above may be incomplete.

## Examples

| Folder | Description | Rendered tutorial |
|---|---|---|
| `piwSN/` | Prior derivation and posterior inference for the skew-normal model | [RPubs](https://rpubs.com/FJRubio/piwSN) |
| `piwBMI/` | Application to BMI data: MLE, MCMC sampling, posterior summaries, predictive densities | [RPubs](https://rpubs.com/FJRubio/piwBMI) |
| `piwNLRM/` | Prior derivation and posterior inference for the normal linear regression model | [RPubs](https://rpubs.com/FJRubio/piwNLRM) |

## Citation

If you use this work, please cite:

```bibtex
@article{li:2022,
  author  = {Li, W. and Rubio, F.J.},
  title   = {On a prior based on the {W}asserstein information matrix},
  journal = {Statistics and Probability Letters},
  volume  = {190},
  pages   = {109645},
  year    = {2022},
  doi     = {10.1016/j.spl.2022.109645}
}
```

## Related resources

- [MOOMIN](https://github.com/FJRubio67/MOOMIN) — a related objective non-local
  prior for the shape parameter of skew-symmetric models
- [StatisticalInference](https://github.com/FJRubio67/StatisticalInference) —
  lecture notes covering the Fisher information matrix and the Jeffreys prior.
