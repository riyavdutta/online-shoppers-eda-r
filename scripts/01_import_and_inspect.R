# 01_import_and_inspect.R
# Purpose: read the raw dataset and check its structure before any analysis.
# This script only looks at the data. It does not change or save anything.

# Load the tidyverse, a collection of packages for working with data
library(tidyverse)

# Read the raw CSV file into a table called shoppers
shoppers <- read_csv("data/raw/online_shoppers_intention.csv")

# Number of rows (sessions) and columns (variables)
dim(shoppers)

# Each column's name, type and first few values
glimpse(shoppers)

# Number of missing values in each column
colSums(is.na(shoppers))

# Number of sessions that did (TRUE) and did not (FALSE) end in a purchase
count(shoppers, Revenue)

# Number of rows that are exact copies of an earlier row
sum(duplicated(shoppers))
