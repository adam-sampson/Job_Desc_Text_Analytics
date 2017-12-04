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
library(stringr)
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
    print(paste(length(fileList),"txt files detected in:",fileDir))
      
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

loadTextDfFromSqLite <- function() {
  return(as.data.frame(select(plaintext.db,id,text)))
}

# test.df <- loadTextDfFromSqLite()
