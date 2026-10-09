# Online Shoppers Purchasing Intention: Exploratory Analysis and Logistic Regression in R

## Overview

This project examines how visitors browse an online shop and which browsing behaviours are associated with completing a purchase. It combines exploratory data analysis with a logistic regression model, and is written in R.

## Aims

1. Describe how browsing behaviour, such as the pages visited and the time spent on them, differs between sessions that end in a purchase and sessions that do not.
2. Estimate which session characteristics are associated with the likelihood of a purchase, using logistic regression.

## Data

The analysis uses the Online Shoppers Purchasing Intention Dataset from the UCI Machine Learning Repository. It contains 12,330 browsing sessions recorded over one year, each belonging to a different user. Each session is described by 17 features and one outcome variable, `Revenue`, which records whether the session ended in a purchase. 1,908 sessions (15.5%) ended in a purchase. There are no missing values.

The raw data file is stored unchanged in `data/raw/online_shoppers_intention.csv`.

## Methods

- **Exploratory data analysis:** summary statistics and visualisations of browsing behaviour, compared across purchasing and non-purchasing sessions.
- **Logistic regression:** a model of the probability of purchase, with diagnostic checks of model assumptions.

## Interpretation

The data are observational. Results describe associations between browsing behaviour and purchasing and should not be interpreted as causal effects.

## Repository structure

```
online-shoppers-eda-r/
├── data/
│   └── raw/                       Original dataset (unchanged)
├── scripts/
│   └── 01_import_and_inspect.R    Reads the raw data and checks its structure
├── online-shoppers-eda-r.Rproj    RStudio project file
└── README.md
```

Open `online-shoppers-eda-r.Rproj` in RStudio before running any script, so that file paths resolve from the project folder.

## Reproducibility

Requirements:

- R 4.5.2 or later
- R packages: `tidyverse`, `broom`, `car`, `rmarkdown`, `knitr`
- pandoc, for rendering reports (included with RStudio)

Install the packages in R with:

```r
install.packages(c("tidyverse", "broom", "car", "rmarkdown", "knitr"))
```

## Citation

Sakar, C. and Kastro, Y. (2018). *Online Shoppers Purchasing Intention Dataset* [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5F88Q

The dataset is licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).
