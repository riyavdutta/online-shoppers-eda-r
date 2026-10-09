# Online Shoppers Purchasing Intention: Exploratory Analysis and Logistic Regression in R

## Overview

This project examines how visitors browse an online shop and which browsing behaviours are associated with completing a purchase. It combines exploratory data analysis with a logistic regression model, and is written in R.

**Read the full report:** [report/analysis.md](report/analysis.md)

## Aims

1. Describe how browsing behaviour, such as the pages visited and the time spent on them, differs between sessions that end in a purchase and sessions that do not.
2. Estimate which session characteristics are associated with the likelihood of a purchase, using logistic regression.

## Data

The analysis uses the Online Shoppers Purchasing Intention Dataset from the UCI Machine Learning Repository. It contains 12,330 browsing sessions recorded over one year, each belonging to a different user. Each session is described by 17 features and one outcome variable, `Revenue`, which records whether the session ended in a purchase. 1,908 sessions (15.5%) ended in a purchase. There are no missing values.

The raw data file is stored unchanged in `data/raw/online_shoppers_intention.csv`.

## Methods

- **Exploratory data analysis:** summary statistics and visualisations of browsing behaviour, compared across purchasing and non-purchasing sessions.
- **Logistic regression:** a model of the probability of purchase based on page counts, exit rate, proximity to a special day, month, visitor type and weekend. Product pages enter on a log scale.
- **Model checks:** overlap between predictors (variance inflation factors), the straight-line assumption on the log-odds scale, influential sessions (Cook's distance), and model fit (McFadden's pseudo R² and AUC).
- **Comparison model:** the Google Analytics page value measure is partly calculated from completed purchases, so it is excluded from the main model and examined in a separate comparison model.

## Key findings

- Sessions that ended in a purchase tended to involve more product pages and pages with lower exit rates.
- Holding the other predictors constant, each doubling of product pages viewed was associated with about 14% higher odds of a purchase, and each percentage point increase in exit rate with about 24% lower odds.
- New visitors had about 54% higher odds of a purchase than returning visitors, and purchase rates were highest in November.
- The main model separated purchase and non-purchase sessions moderately well (AUC 0.75). Adding page value raised the AUC to 0.92, but mainly because that measure is partly derived from purchases.

The data are observational. These results describe associations between browsing behaviour and purchasing and should not be interpreted as causal effects. Further limitations are discussed in the report.

## Repository structure

```
online-shoppers-eda-r/
├── data/
│   ├── raw/                       Original dataset (unchanged)
│   └── processed/                 Cleaned data, created by 02_clean.R (not tracked by git)
├── scripts/
│   ├── 01_import_and_inspect.R    Reads the raw data and checks its structure
│   └── 02_clean.R                 Sets correct column types and saves the cleaned data
├── report/
│   ├── analysis.Rmd               R Markdown source of the report
│   ├── analysis.md                Rendered report (readable directly on GitHub)
│   └── analysis_files/            Figures used by the rendered report
├── online-shoppers-eda-r.Rproj    RStudio project file
├── CLAUDE.md                      Project rules followed when working with an AI coding assistant
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

To reproduce the report, open `report/analysis.Rmd` in RStudio and click **Knit**. The report runs the cleaning script itself, so it can be rendered from the raw data alone.

## Citation

Sakar, C. and Kastro, Y. (2018). *Online Shoppers Purchasing Intention Dataset* [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5F88Q

The dataset is licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).
