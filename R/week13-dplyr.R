# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(dplyr)

# Data Import and Cleaning
week13_tbl <- tibble(read.csv(file ="../data/week13.csv"))

# Analysis - dplyr
## Count of managers
count(week13_tbl)

## Count of distinct managers
distinct(week13_tbl, pick(employee_id)) %>%
  count()

## Number of managers by location, not originally hired as managers
group_by(week13_tbl, city) %>%
  filter(manager_hire == "N") %>%
  count(city)

## Avg years employeed, sd of years employed by performance group
group_by(week13_tbl, performance_group) %>%
  summarize(avg = mean(yrs_employed),
            sd = sd(yrs_employed))

## Top 3 managers by location, sorted first by city and then test score. Ties included
group_by(week13_tbl, city) %>%
  slice_max(n = 3, 
            order_by = tibble(city, test_score), #tibble made per documentation
            with_ties = TRUE) %>%
  select(employee_id, city) #add test_score to verify test_score descending order
