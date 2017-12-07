##  Call in the working libraries

library(XML)
library(plyr)
library(stringr)
library(tidyr)
library(dplyr)
library(dbplyr)
library(RMySQL)
library(xlsx)
library(readr)
library(svDialogs)
library(DBI)
library(tm)
library(class)
library(RSQLite)
library(lsa)


##  Saves the pathname for the data set folders
pathcommon <- "C:/Users/natha/Documents/Bellarmine Advanced Analytics/2017-3 Fall Term Group Project/Job_Desc_Text_Analytics/webscraping/"
#pathcommon <- "H:/New folder/Term Project/webscraping"

##########################################################################################################
################  Apple      #############################################################################
##########################################################################################################

##  Code chunk that creates the file path name for each company ####
company <- "Apple_job_scraping/files"
pathname <- paste(pathcommon, company, sep = "/", collapse = "")
apple_df <- as.data.frame(list.files(path=pathname), stringsAsFactors = FALSE)
colnames(apple_df) <- "filename"
apple_df$file <- pathname
apple_df$filepath <- paste(apple_df$file, apple_df$filename, sep = "/")
apple_df <- apple_df[-c(988:989),]

##  Extracts the Job ID and creates the jobid column
apple_df$jobid <- sapply(seq(apple_df$filepath), function(i){
  apple_data <- htmlTreeParse(apple_df$filepath[i], useInternal = TRUE)
  apple_jobid <- unlist(xpathApply(apple_data, '//ul/li[1]'))
  apple_jobid <- xmlValue(apple_jobid[[1]])
  apple_jobid <- str_replace(apple_jobid, "Job Number: ", '')
})

##  Extracts the Job Title and creates the jobtitle column
apple_df$jobtitle <- sapply(seq(apple_df$filepath), function(i){
  apple_data <- htmlTreeParse(apple_df$filepath[i], useInternal = TRUE)
  apple_title <- unlist(xpathApply(apple_data, '//h2', xmlValue))
})

##  Extracts the descriptive text for the jobs and creates the jobdesc column
apple_df$jobdesc <- sapply(seq(apple_df$filepath), function(i){
  apple_data <- htmlTreeParse(apple_df$filepath[i], useInternal = TRUE)
  apple_desc1 <- unlist(xpathApply(apple_data, '//p', xmlValue))
  apple_desc1 <- gsub('\\n', ' ', apple_desc1)
  apple_desc1 <- gsub('\\r', ' ', apple_desc1)
  apple_desc1 <- gsub("Ã¢Â€Â™",'\'', apple_desc1)
  apple_desc1 <- paste(apple_desc1, collapse = '')
  apple_desc2 <- unlist(xpathApply(apple_data, '//li', xmlValue))
  apple_desc2 <- gsub("Ã¢Â€Â™",'\'', apple_desc2)
  apple_desc <- paste(apple_desc1, apple_desc2, collapse = '')
})

##  Creates a new data frame with only the jobid, jobtitle, and jobdesc columns
apple.db <- apple_df[,c(4:6)]
apple.db$company <- "Apple"

##########################################################################################################
################  Microsoft  #############################################################################
##########################################################################################################

##  Code chunk that creates the file path name for each company ####
company <- "Microsoft_job_scraping/files"
pathname <- paste(pathcommon, company, sep = "/", collapse = "")
ms_df <- as.data.frame(list.files(path=pathname), stringsAsFactors = FALSE)
colnames(ms_df) <- "filename"
ms_df$file <- pathname
ms_df$filepath <- paste(ms_df$file, ms_df$filename, sep = "/")
ms_df <- ms_df[-c(86,348),]

##  Extracts the Job ID and creates the jobid column
ms_df$jobid <- sapply(seq(ms_df$filepath), function(i){
  ms_data <- htmlTreeParse(ms_df$filepath[i], useInternal = TRUE)
  ms_jobid <- unlist(xpathApply(ms_data, '//ul/li/a', xmlGetAttr, 'href'))
  ms_jobid <- gsub("^.*?[jid]=","",ms_jobid)
  ms_jobid <-substr(ms_jobid[1], start=1, stop=6)
})

##  Extracts the Job Title and creates the jobtitle column
ms_df$jobtitle <- sapply(seq(ms_df$filepath), function(i){
  ms_data <- htmlTreeParse(ms_df$filepath[i], useInternal = TRUE)
  ms_title <- unlist(xpathApply(ms_data, '//h1', xmlValue))
  ms_title <- gsub('\\n', '', ms_title)
  ms_title <- gsub("^\\s+","",ms_title)
})

##  Extracts the descriptive text for the jobs and creates the jobdesc column
ms_df$jobdesc <- sapply(seq(ms_df$filepath), function(i){
  ms_data <- htmlTreeParse(ms_df$filepath[i], useInternal = TRUE)
  ms_desc <- unlist(xpathApply(ms_data, '//p', xmlValue))
  ms_desc <- gsub('\\n', ' ', ms_desc)
  ms_desc <- gsub('\\r', ' ', ms_desc)
  ms_desc <- paste(ms_desc, collapse = '')
})

##  Creates a new data frame with only the jobid, jobtitle, and jobdesc columns
microsoft.db <- ms_df[,c(4:6)]
microsoft.db$company <- "Microsoft"

##########################################################################################################
################  Humana  ################################################################################
##########################################################################################################

##  Code chunk that creates the file path name for each company ####
company <- "Humana_job_scraping/files"
pathname <- paste(pathcommon, company, sep = "/", collapse = "")
humana_df <- as.data.frame(list.files(path=pathname), stringsAsFactors = FALSE)
colnames(humana_df) <- "filename"
humana_df$file <- pathname
humana_df$filepath <- paste(humana_df$file, humana_df$filename, sep = "/")
humana_df <- humana_df[-c(80,88,163),]

##  Extracts the Job ID and creates the jobid column
humana_df$jobid <- sapply(seq(humana_df$filepath), function(i){
  humana_data <- htmlTreeParse(humana_df$filepath[i], useInternal = TRUE)
  humana_jobid <- unlist(xpathApply(humana_data, '//div', xmlValue))
  humana_jobid <- humana_jobid[[2]]
  humana_jobid <- gsub('\\n', '', humana_jobid)
  humana_jobid <- gsub(".*?:","",humana_jobid)
  humana_jobid <-substr(humana_jobid, start=5, stop=10)
})

##  Extracts the Job Title and creates the jobtitle column
humana_df$jobtitle <- sapply(seq(humana_df$filepath), function(i){
  humana_data <- htmlTreeParse(humana_df$filepath[i], useInternal = TRUE)
  humana_title <- unlist(xpathApply(humana_data, '//div', xmlValue))
  humana_title <- humana_title[[2]]
  humana_title <- gsub('\\n', '', humana_title)
  humana_title <- gsub(":.*?$","",humana_title)
})

##  Extracts the descriptive text for the jobs and creates the jobdesc column
humana_df$jobdesc <- sapply(seq(humana_df$filepath), function(i){
  humana_data <- htmlTreeParse(humana_df$filepath[i], useInternal = TRUE)
  humana_desc1 <- unlist(xpathApply(humana_data, '//div', xmlValue))
  humana_desc1a <- humana_desc1[[1]]
  humana_desc1 <- paste(humana_desc1a, sep = '')
  humana_desc1 <- gsub('\\n', ' ', humana_desc1)
  humana_desc1 <- gsub('\\r', ' ', humana_desc1)
  humana_desc2 <- unlist(xpathApply(humana_data, '//ul', xmlValue))
  humana_desc2 <- gsub('\\n', ' ', humana_desc2)
  humana_desc2 <- gsub('\\r', ' ', humana_desc2)
  humana_desc2 <- paste(humana_desc2, collapse = '')
  humana_desc <- paste(humana_desc1, humana_desc2, collapse = '')
})

##  Creates a new data frame with only the jobid, jobtitle, and jobdesc columns
humana.db <- humana_df[,c(4:6)]
humana.db$company <- "Humana"

##########################################################################################################
################  Dice  ##################################################################################
##########################################################################################################

##  Code chunk that creates the file path name for each company ####
company <- "Dice_job_scraping/files"
pathname <- paste(pathcommon, company, sep = "/", collapse = "")
dice_df <- as.data.frame(list.files(path=pathname), stringsAsFactors = FALSE)
colnames(dice_df) <- "filename"
dice_df$file <- pathname
dice_df$filepath <- paste(dice_df$file, dice_df$filename, sep = "/")
dice_df <- dice_df[-c(186,258),]
dice_df$filepath2 <- paste(dice_df$file, "txt", dice_df$filename, sep = "/")
dice_df$filepath2 <- gsub('.xml','.txt',dice_df$filepath2)

##  Extracts the Job ID and creates the jobid column
dice_df$jobid <- dice_df$filename
dice_df$jobid <- gsub("^._","",dice_df$jobid)
dice_df$jobid <- gsub(".xml","", dice_df$jobid)

##  Extracts the Job Title and creates the jobtitle column
dice_df$jobtitle <- "No Job Title"
##Job title not able to be extrated from this data

##  Extracts the descriptive text for the jobs and creates the jobdesc column
dice_df$jobdesc <- sapply(seq(dice_df$filepath2), function(i){
  dice_data <- read_file(dice_df$filepath2[i])
})

dice.db <- dice_df[,5:7]
dice.db$company <- "Dice"

##########################################################################################################
################  Walmart  ###############################################################################
##########################################################################################################

##  Code chunk that creates the file path name for each company ####
company <- "Walmart_job_scraping"
pathname <- paste(pathcommon, company, sep = "/", collapse = "")
walmart_df <- read.csv(paste(pathname,"Jobs.csv", sep = "/"))
walmart_df <- walmart_df[,-1]
walmart_df$jobid <- substr(walmart_df[,1], start=1, stop=6)
walmart_df$jobtitle <- substr(walmart_df[,1], start=8, stop = 99)
walmart_df$jobtitle <- gsub("bentonville ar", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("reston va\"", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("sunnyvale ca\"", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("isd", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("isd east", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("east", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("san bruno ca\"", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("austin tx\"", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("midway tn\"", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("buckeye az\"", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub("carlsbad ca\"", "", walmart_df$jobtitle)
walmart_df$jobtitle <- gsub(" \"", "", walmart_df$jobtitle)
walmart_df$jobdesc <- paste(walmart_df$job_total, walmart_df$joboverviewoverview_total)

##  Creates a new data frame with only the jobid, jobtitle, and jobdesc columns
walmart.db <- walmart_df[,c(4:6)]
walmart.db$company <- "Walmart"


##########################################################################################################
##  Combining all data for the final db  #################################################################
##########################################################################################################



text.df <- rbind(apple.db, dice.db, humana.db, microsoft.db, walmart.db)


#---
# Load data from database
#---

db.conn = dbConnect(SQLite(), dbname="JobsTextData.sqlite")
jobs.df <- as.data.frame(tbl(db.conn,"jobCleanedText"))
# rm(db.conn)

#---
# Clean data even more
#---
# Remove everything except for [a-zA-Z] [:space:] ' + - and replace with space
text.df$jobdesc <- str_replace_all(text.df$jobdesc,"[^a-zA-Z[:space:]+\\-\']"," ")
# Remove ' and replace with nothing.
text.df$jobdesc <- str_replace_all(text.df$jobdesc,"\'","")

#---
# Prepare data for use as corpus and tdm
#---
jobs.corpus <- Corpus(DataframeSource(data.frame(doc_id = text.df$jobid,
                                                 text = text.df$jobdesc,
                                                 stringsAsFactors = FALSE)))
# print(jobs.corpus)
# inspect(jobs.corpus[1:5])
# meta(jobs.corpus[[1]])
# inspect(jobs.corpus[[1]])
# lapply(jobs.corpus[[1]]$content[[2]],as.character)

jobs.corpus <- tm_map(jobs.corpus,PlainTextDocument)
jobs.corpus <- tm_map(jobs.corpus,content_transformer(tolower))
jobs.corpus <- tm_map(jobs.corpus,removeWords,stopwords("english"))
jobs.corpus <- tm_map(jobs.corpus,stripWhitespace)
# print(jobs.corpus)
# inspect(jobs.corpus[1:5])
# meta(jobs.corpus[[1]])
# inspect(jobs.corpus[[1]])
# lapply(jobs.corpus[[1]]$content[[2]],as.character)

