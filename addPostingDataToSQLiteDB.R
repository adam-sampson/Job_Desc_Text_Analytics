library(RSQLite)
conn <- dbConnect(RSQLite::SQLite(), dbname="myDB")
dbWriteTable(conn,"mytable",df)
alltables <- dbListTables(conn)

library(dplyr)
library(dbplyr)
my_db <- tbl(conn, "mytable")
my_db
# Use dplyr functions to query data...
my_db %>% select(X1)
