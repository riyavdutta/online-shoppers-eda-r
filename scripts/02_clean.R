# 02_clean.R
# Purpose: prepare the raw data for analysis and save a cleaned copy.
# The raw file in data/raw/ is never changed. The cleaned copy is saved in data/processed/.

# Load the tidyverse
library(tidyverse)

# Read the raw CSV file (show_col_types = FALSE hides the column summary message)
shoppers_raw <- read_csv("data/raw/online_shoppers_intention.csv", show_col_types = FALSE)

# Months in calendar order. January and April do not appear in the data.
month_order <- c("Feb", "Mar", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")

# Create a cleaned copy of the data
shoppers <- shoppers_raw |>
  mutate(
    # Spell June with three letters, like the other months
    Month = if_else(Month == "June", "Jun", Month),
    # Store Month as a category, with its levels in calendar order
    Month = factor(Month, levels = month_order),
    # These columns hold category codes, not quantities, so store them as categories
    OperatingSystems = factor(OperatingSystems),
    Browser = factor(Browser),
    Region = factor(Region),
    TrafficType = factor(TrafficType),
    VisitorType = factor(VisitorType)
  )

# Duplicate rows: 125 rows are identical to an earlier row. All of them have one or two
# product pages, no recorded time on any page and no purchase. They are most likely
# different visitors who left almost immediately, so they are kept.

# Safety checks: stop with an error if something went wrong
stopifnot(nrow(shoppers) == nrow(shoppers_raw))  # no rows were lost
stopifnot(!anyNA(shoppers$Month))                 # every month matched a level in month_order

# Show the cleaned data's columns and types
glimpse(shoppers)

# Save the cleaned data. The .rds format keeps the column types we just set,
# which a CSV file would lose.
dir.create("data/processed", showWarnings = FALSE)
write_rds(shoppers, "data/processed/shoppers_clean.rds")
