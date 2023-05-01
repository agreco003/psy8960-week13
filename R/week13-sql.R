# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(keyring)
library(RMariaDB)

# Data Import and Cleaning
## keyring password set via notes previously, not saved here per instruction. Data not exactly imported, but this creates the connection to the mariaDB
conn <- dbConnect(MariaDB(),
                  user="greco031",
                  password=key_get("latis-mysql","greco031"),
                  host="dba-mysql-prd-05.oit.umn.edu",
                  port=3306,
                  ssl.ca = 'mysql_hotel_umn_20220728_interm.cer'
)

# Analysis - SQL
## Count of Managers
dbGetQuery(conn,"SELECT COUNT(employee_id) AS manager_count
          FROM cla_tntlab.datascience_8960_table;"
)
## Distinct Manager IDs
dbGetQuery(conn,"SELECT COUNT(DISTINCT employee_id) AS distinct_manager_count
           FROM cla_tntlab.datascience_8960_table;"
)

## Number of Managers by city, not hired as managers
dbGetQuery(conn, "SELECT city, COUNT(employee_id) 
           FROM cla_tntlab.datascience_8960_table
           WHERE manager_hire = 'N' 
           GROUP BY city;"
)
## Avg years employed, sd of years employed by performance group. No rounding instructed
dbGetQuery(conn, "SELECT performance_group, AVG(yrs_employed), STDDEV(yrs_employed)
	FROM cla_tntlab.datascience_8960_table
	GROUP BY performance_group;"
)
## Top 3 managers by location, sorted first by city and then test score. Ties included. RANK() function used. Could use DENSE_RANK() but would not match dplyr result (2 extra results). 
dbGetQuery(conn, "WITH added_ranking AS (
           SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY city, test_score DESC) AS ranking
           FROM cla_tntlab.datascience_8960_table
          ) 
           SELECT city, employee_id, test_score
           FROM added_ranking
           WHERE ranking <= 3"
)