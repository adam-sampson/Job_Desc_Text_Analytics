####################
# This script is designed to convert html/xml files to basic text files
# It does not capture any data that is located in the xml tags, only text. 
# It essentially removes all tags completely.
####################

library(XML)
library(stringr)
library(readr)

setwd(projectDir)
projectDir <- getwd()

# List all webscraping dirs
  dirList <- list.dirs("./webscraping")
  
  # Keep only dirs that end in /files
  dirList <- str_subset(dirList,".+/files$")
  
# For each directory found, do the conversion
  for(fileDir in dirList) {
    setwd(projectDir)
    
    setwd(fileDir)
    
    fileList <- list.files(pattern=".+xml$")
    print(paste(length(fileList),"xml files detected in:",fileDir))
    
    # If txt directory does not exist then create it for somewhere to put txt files
    if(length(str_subset(list.dirs(),".+/txt$")) == 0) {
      print(paste("txt dir not detected in",fileDir,"... creating"))
      dir.create("/txt")
    }

    # Now read in each file, remove xml, and save to /txt    
    for(ind.file in fileList) {
      # read in file
      temp <- read_file(ind.file)
      
      # remove all xml/html tags
      temp <- str_replace_all(temp,"<[^>]+>","")
      
      # remove extra \r and \n
      temp <- str_replace_all(temp,"\\\r"," ")
      temp <- str_replace_all(temp,"\\\n"," ")
      
      # remove exra spaces
      temp <- str_replace_all(temp,"\\s{2,}"," ")
      
      # remove broken xml fragments
      temp <- str_replace_all(temp,"googletag.+-->","")
      
      # save text only file in txt directory
      fileName <- str_replace(ind.file, ".xml", "")
      fileName <- paste0(fileName,".txt")
      
      write_file(temp,path = paste0("./txt/",fileName),append=FALSE)
    }
  }
    