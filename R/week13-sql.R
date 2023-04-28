# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(keyring)
library(RMariaDB)

# Data Import and Cleaning
## keyring password set via notes previously, not saved here per instruction
conn <- dbConnect(MariaDB(),
                  user="greco031",
                  password=key_get("latis-mysql","greco031"),
                  host="dba-mysql-prd-05.oit.umn.edu",
                  port=3306,
                  ssl.ca = 'mysql_hotel_umn_20220728_interm.cer'
)
databases_df <- dbGetQuery(conn, "SHOW DATABASES;")
dbExecute(conn, "USE cla_tntlab;")
