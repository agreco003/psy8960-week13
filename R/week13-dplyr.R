# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(dplyr)

# Data Import and Cleaning
# conn <- dbConnect(MariaDB(),
#                   user="greco031",
#                   password=key_get("latis-mysql","greco031"),
#                   host="dba-mysql-prd-05.oit.umn.edu",
#                   port=3306,
#                   ssl.ca = 'mysql_hotel_umn_20220728_interm.cer'
# ) #could also just do this automatically
# dbExecute(conn, "USE cla_tntlab;")
# week13_tbl <- dbGetQuery(conn, "SELECT * FROM cla_tntlab.datascience_8960_table")

week13_tbl <- tibble(read.csv(file ="../data/week13.csv")) #could also use read_csv from readr in tidyverse, but wanted to do this to ensure dplyr package only

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
  select(employee_id, city, test_score)
