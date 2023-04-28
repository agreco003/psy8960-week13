library(keyring)
library(RMariaDB)
#keyring password set via notes previously, not saved here per instruction
conn <- dbConnect(MariaDB(),
                  user="greco031",
                  password=key_get("latis-mysql","greco031"),
                  host="mysql-prod5.oit.umn.edu",
                  port=3306,
)
databases_df <- dbGetQuery(conn, "SHOW DATABASES;")
dbExecute(conn, "USE cla_tntlab;")