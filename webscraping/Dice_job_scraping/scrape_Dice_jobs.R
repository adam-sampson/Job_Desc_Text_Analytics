library(RSelenium)
library(XML)
library(stringr)

# set up functions to make coding easier
randDelay <- function(min,max) {
  Sys.sleep(round(runif(n=1,min=min,max=max),digits = 3))
}

# Set the working directory where 
# Project directory starts at something like: setwd("~/MSA/Fall 2017/Job_Desc_Text_Analytics")
setwd(paste0(getwd(),"/webscraping/Dice_job_scraping/files/"))


# Connect to running Docker server
  remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",port = 4445L,nativeEvents = FALSE,javascript = FALSE)
  
  remDr$open()

## Search job by keyword
  searchTerm <- "data"
  searchPage <- 1
  # searchURL <- paste0("https://www.dice.com/jobs?q=",searchTerm,"&l=")
  searchURL <- paste0("https://www.dice.com/jobs/q-data-startPage-",searchPage,"-jobs?q=",searchTerm)
  
  remDr$navigate(searchURL)
  randDelay(min=2,max=3)
  remDr$screenshot(display = TRUE)

# Find links by xpath
# //*[@id="position0"]
  # jobListElems <- remDr$findElements('xpath',"//*[@id=\"position0\"]")
  jobListElems <- remDr$findElements('xpath',"//a[contains(@id,\"position\")]")
  
  # Elements 1 to length/2 have the links for the job which can be accessed using
  # as.character(jobListElems[[1]]$getElementAttribute("href"))
  # remDr$navigate(as.character(jobListElems[[1]]$getElementAttribute("href")))
  
  jobListElemsTrimmed <- jobListElems[1:(length(jobListElems)/2)]

# Create a function to convert object to list of urls. Elements are not usable after leaving current page
  elemToUrlList <- function(elemList) {
    outList <- list()
    for(i in 1:(length(elemList))) {
      outList[i] <- elemList[[i]]$getElementAttribute("href")
    }
    return(outList)
  }

  jobUrlList <- elemToUrlList(jobListElemsTrimmed)
    

  
# create a function to scrape an actual job posting on the current page
  getDiceIdPostingID <- function() {
    temp <- remDr$findElement('xpath',"//div[@class=\"company-header-info\"]")
    temp <- temp$getElementText()
    temp2 <- str_extract_all(temp,"(:\\s\\w+)+")
    temp2 <- paste0(temp2[[1]][1],temp2[[1]][2])
    temp2 <- str_replace_all(temp2,":\\s"," ")          
    temp2 <- trimws(temp2)
    temp2 <- str_replace_all(temp2,"\\s","_")
    return(temp2)
  }
  
  scrapeJobPosting <- function() {
    jobID <- getDiceIdPostingID()
    
    # The part of the page with the actual job info is at xpath: 
    # //*[@id="bd"]/div[2]/div[1]/div[5]/div
    # //div[@class="col-md-9"]/div[@class="row"]
    jobText <- remDr$findElement('xpath',"//div[@class=\"col-md-9\"]")
    
    jobDescRaw <- jobText$getElementAttribute("innerHTML")
    jobDescText <- htmlParse(jobDescRaw, asText = TRUE, encoding="UTF-8")
    print(paste0("Writing job ",jobID))
    write(paste0("Writting job desc: ",jobID),file="log.txt",append = TRUE)
    saveXML(jobDescText,
            file = paste0(jobID,".xml"))
  }
  
  # scrapeJobPosting()
  
# Create a function to scrape all the job links on a single search page
  scrapeOnePageListOfJobLinks <- function(urlList) {
    for(url in urlList) {
      print(url)
      remDr$navigate(url)
      randDelay(2,3)
      remDr$screenshot(display = TRUE)
      
      scrapeJobPosting()
    }
  }
  
  # scrapeOnePageListOfJobLinks(urlList = jobUrlList)  
  
# Create a function to move to scrape from page to page
  scrapeAllDice <- function() {
    searchTerm <- "data"
    for(searchPage in 1:330) {
      print(paste("Scraping page:",searchPage))
      write(paste0("Scraping Dice Page: ",searchPage),file="log.txt",append = TRUE)
      searchURL <- paste0("https://www.dice.com/jobs/q-data-startPage-",searchPage,"-jobs?q=",searchTerm)
      
      remDr$navigate(searchURL)
      randDelay(min=2,max=3)
      remDr$screenshot(display = TRUE)
      
      jobListElems <- remDr$findElements('xpath',"//a[contains(@id,\"position\")]")
      jobListElemsTrimmed <- jobListElems[1:(length(jobListElems)/2)]
      
      jobUrlList <- elemToUrlList(jobListElemsTrimmed)
      
      scrapeOnePageListOfJobLinks(urlList = jobUrlList)
      
      
    }
    
    
    
  }

  scrapeAllDice()  
  