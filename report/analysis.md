Online Shoppers Purchasing Intention: Exploratory Analysis and Logistic
Regression
================
Riya Dutta
09 October 2026

- [1. Introduction](#1-introduction)
- [2. Data](#2-data)
- [3. Exploratory analysis](#3-exploratory-analysis)
  - [3.1 Browsing behaviour by purchase
    outcome](#31-browsing-behaviour-by-purchase-outcome)
  - [3.2 Purchase rate by visitor
    characteristics](#32-purchase-rate-by-visitor-characteristics)
- [References](#references)

## 1. Introduction

This report examines how visitors browse an online shop and which
browsing behaviours are associated with completing a purchase. The data
are observational, so all results describe associations and should not
be interpreted as causal effects.

## 2. Data

The analysis uses the Online Shoppers Purchasing Intention Dataset
(Sakar and Kastro, 2018). Each row is one browsing session, and the
outcome variable `Revenue` records whether the session ended in a
purchase.

| Variable | Description |
|----|----|
| `Administrative`, `Informational`, `ProductRelated` | Number of pages of each type visited in the session |
| `Administrative_Duration`, `Informational_Duration`, `ProductRelated_Duration` | Total time spent on each page type, in seconds |
| `BounceRates` | Average bounce rate of the pages visited (share of visitors who entered on that page and left without further interaction) |
| `ExitRates` | Average exit rate of the pages visited (share of page views that were the last in a session) |
| `PageValues` | Average Google Analytics page value of the pages visited, which is calculated from pages that preceded completed transactions |
| `SpecialDay` | Closeness of the visit date to a special day such as Valentine’s Day, from 0 (not close) to 1 |
| `Month` | Month of the visit |
| `OperatingSystems`, `Browser`, `Region`, `TrafficType` | Category codes for the visitor’s technology, location and traffic source |
| `VisitorType` | New, returning or other visitor |
| `Weekend` | Whether the visit took place at the weekend |
| `Revenue` | Whether the session ended in a purchase (outcome) |

The data are prepared by `scripts/02_clean.R`, which sets the correct
variable types. The 125 duplicate rows are kept, because they are
consistent with separate very short visits rather than recording errors.

``` r
# Load the tidyverse and create the cleaned table called shoppers
library(tidyverse)
source("scripts/02_clean.R")
```

## 3. Exploratory analysis

### 3.1 Browsing behaviour by purchase outcome

The table compares the median and mean of each browsing measure between
sessions that did and did not end in a purchase. Medians are reported
alongside means because most measures are strongly right-skewed: many
sessions have values of zero and a few have very large values.

``` r
browsing_summary <- shoppers |>
  # Label the outcome in words
  mutate(Outcome = if_else(Revenue, "Purchase", "No purchase")) |>
  # Reshape so that each row holds one measure for one session
  pivot_longer(Administrative:SpecialDay, names_to = "Measure", values_to = "value") |>
  # Keep the measures in their original column order
  mutate(Measure = fct_inorder(Measure)) |>
  # Calculate the median and mean of each measure for each outcome
  group_by(Measure, Outcome) |>
  summarise(Median = median(value), Mean = mean(value), .groups = "drop") |>
  # Place the two outcomes side by side
  pivot_wider(names_from = Outcome, values_from = c(Median, Mean), names_sep = ": ")

knitr::kable(browsing_summary, digits = 3)
```

| Measure | Median: No purchase | Median: Purchase | Mean: No purchase | Mean: Purchase |
|:---|---:|---:|---:|---:|
| Administrative | 0.000 | 2.000 | 2.118 | 3.394 |
| Administrative_Duration | 0.000 | 52.367 | 73.740 | 119.483 |
| Informational | 0.000 | 0.000 | 0.452 | 0.786 |
| Informational_Duration | 0.000 | 0.000 | 30.236 | 57.611 |
| ProductRelated | 16.000 | 29.000 | 28.715 | 48.210 |
| ProductRelated_Duration | 510.190 | 1109.906 | 1069.988 | 1876.210 |
| BounceRates | 0.004 | 0.000 | 0.025 | 0.005 |
| ExitRates | 0.029 | 0.016 | 0.047 | 0.020 |
| PageValues | 0.000 | 16.758 | 1.976 | 27.265 |
| SpecialDay | 0.000 | 0.000 | 0.068 | 0.023 |

On average, sessions that ended in a purchase involved more pages and
more time on every page type, and had lower bounce and exit rates, than
sessions that did not. Most sessions in both groups included no
informational pages, so the medians for these two measures are zero. The
largest difference is in `PageValues`: 89% of sessions without a
purchase have a page value of zero, compared with 19% of sessions with a
purchase. Because page value is calculated from pages that preceded
completed transactions, this variable is partly derived from the
outcome, which needs to be considered before it is used in a model.

### 3.2 Purchase rate by visitor characteristics

The purchase rate is the share of sessions in each group that ended in a
purchase. Across all sessions it is 15.5%.

``` r
shoppers |>
  group_by(VisitorType) |>
  summarise(Sessions = n(), Purchases = sum(Revenue), `Purchase rate` = mean(Revenue)) |>
  knitr::kable(digits = 3)
```

| VisitorType       | Sessions | Purchases | Purchase rate |
|:------------------|---------:|----------:|--------------:|
| New_Visitor       |     1694 |       422 |         0.249 |
| Other             |       85 |        16 |         0.188 |
| Returning_Visitor |    10551 |      1470 |         0.139 |

``` r
shoppers |>
  group_by(Weekend) |>
  summarise(Sessions = n(), Purchases = sum(Revenue), `Purchase rate` = mean(Revenue)) |>
  knitr::kable(digits = 3)
```

| Weekend | Sessions | Purchases | Purchase rate |
|:--------|---------:|----------:|--------------:|
| FALSE   |     9462 |      1409 |         0.149 |
| TRUE    |     2868 |       499 |         0.174 |

``` r
shoppers |>
  group_by(Month) |>
  summarise(Sessions = n(), Purchases = sum(Revenue), `Purchase rate` = mean(Revenue)) |>
  knitr::kable(digits = 3)
```

| Month | Sessions | Purchases | Purchase rate |
|:------|---------:|----------:|--------------:|
| Feb   |      184 |         3 |         0.016 |
| Mar   |     1907 |       192 |         0.101 |
| May   |     3364 |       365 |         0.109 |
| Jun   |      288 |        29 |         0.101 |
| Jul   |      432 |        66 |         0.153 |
| Aug   |      433 |        76 |         0.176 |
| Sep   |      448 |        86 |         0.192 |
| Oct   |      549 |       115 |         0.209 |
| Nov   |     2998 |       760 |         0.254 |
| Dec   |     1727 |       216 |         0.125 |

New visitors had a higher purchase rate (24.9%) than returning visitors
(13.9%), and weekend sessions had a slightly higher rate (17.4%) than
weekday sessions (14.9%). Purchase rates varied by month, from 1.6% in
February to 25.4% in November. The number of sessions also differs
widely between months, and January and April are absent from the data,
so monthly patterns should be read with caution.

## References

Sakar, C. and Kastro, Y. (2018). *Online Shoppers Purchasing Intention
Dataset* \[Dataset\]. UCI Machine Learning Repository.
<https://doi.org/10.24432/C5F88Q>. Licensed under CC BY 4.0.
