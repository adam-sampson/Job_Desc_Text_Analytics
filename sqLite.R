###################
# Manage a local sqLite database
###################

# install.packages('RSQLite', dependencies = T)
# install.packages('dbplyr', dependencies = T)
# install.packages('data.table', dependencies = T)
library(RSQLite)
library(dplyr)
library(dbplyr)
# library(data.table)
library(stringi)
library(readr)

projectDir <- getwd()
# projectDir <- "C:/Users/samps/Documents/MSA/Fall 2017/Job_Desc_Text_Analytics"
setwd(projectDir)
getwd()

db.conn = dbConnect(SQLite(), dbname="JobsTextData.sqlite")

plaintext.db <- tbl(db.conn,"jobPlainText")

addTxtFilesToTable <- function() {
  setwd(projectDir)
  # List all webscraping dirs
  dirList <- list.dirs("./webscraping")
  
  # Keep only dirs that end in /files/txt
  dirList <- str_subset(dirList,".+/files/txt$")
  print(paste(length(dirList),"txt directories detected in:"))
  
  out.dt <- data.frame(id = character(),text = character())
  
  # Add all txt files in directories to the data.table
  for(ind.dir in dirList) {
    setwd(projectDir)
    setwd(ind.dir)
    
    fileList <- list.files(pattern=".+txt$")
    print(paste(length(fileList),"txt files detected in:",ind.dir))
      
    for(ind.file in fileList) {
      fileName <- str_replace(ind.file,".txt","")
      
      fileText <- read_file(ind.file)
      
      out.dt <- rbind(out.dt,data.frame(id=fileName,text=fileText))
    }
  }
  # Now add the data to the sqLite database
  # db_list_tables(db.conn)
  copy_to(db.conn,out.dt,"jobPlainText",temporary=FALSE,overwrite=TRUE)
  # return(out.dt)
}

# addTxtFilesToTable()

addWalmartCsVToTable <- function() {
  setwd(projectDir)
  setwd("./webscraping/Walmart/")
  walmart.df <- read_csv("Jobs.csv")
  walmart.df <- data.frame(id = walmart.df$ID.Title, text = paste(walmart.df$job_total, walmart.df$joboverviewoverview_total))
  
  #remove tabs and spaces from id column
  walmart.df$id <- str_replace_all(walmart.df$id,"\\t","_")
  walmart.df$id <- str_replace_all(walmart.df$id, " ","_")
  
  #remove non-text characters from the text column
  walmart.df$text <- str_replace_all(walmart.df$text,"\\t"," ")
  walmart.df$text <- str_replace_all(walmart.df$text,"<\uFFFD>"," ")
  walmart.df$text <- str_replace_all(walmart.df$text, "\\s{2,}"," ")
  
  dbWriteTable(db.conn,"jobPlainText",walmart.df,temporary=FALSE,append=TRUE)
  # return(walmart.df)
}

# addWalmartCsVToTable()

loadTextDfFromSqLite <- function() {
  return(as.data.frame(select(plaintext.db,id,text)))
}

# test.df <- loadTextDfFromSqLite()
