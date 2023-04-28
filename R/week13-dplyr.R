setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
week13_tbl <- read_csv(file ="../data/week13.csv")