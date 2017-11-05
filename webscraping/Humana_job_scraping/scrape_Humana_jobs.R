library(RSelenium)
library(XML)
library(stringr)

# Set the working directory where 
# Project directory starts at something like: setwd("~/MSA/Fall 2017/Job_Desc_Text_Analytics")
setwd(paste0(getwd(),"/webscraping/Humana_job_scraping/files/"))

remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",port = 4445L)
remDr$open()

## Verify connection visually
  remDr$navigate("https://humana.taleo.net/careersection/externalus/moresearch.ftl?=lang")
  remDr$getCurrentUrl()
  remDr$getTitle()
  remDr$screenshot(display = TRUE)
  
## Search job by keyword
  # The Humana jobs site requires us to use their form.
  searchTerm <- "data"
  
  # The <input name="keyword" id="advancedSearchInterface.keywordInput">  is where to enter search term
  #inputElem <- remDr$findElement('xpath',"//input[@id=\"advancedSearchFooterInterface.searchAction\"]")
  inputElem <- remDr$findElement('xpath',"//*[@id=\"advancedSearchInterface.keywordInput\"]")
  inputElem$sendKeysToElement(list("data"))
  remDr$screenshot(display = TRUE)
  inputElem$sendKeysToElement(list(key = "enter"))
  Sys.sleep(round(runif(n=1,min=1,max=1),digits = 3))
  remDr$screenshot(display = TRUE)
  
## Collect all the links on the page
  # the links are located in <a id="requisitionListInterface.reqTitleLinkAction.row1"> //*[@id="requisitionListInterface.reqTitleLinkAction.row1"]
  # for a more general info, title="View this role description"
  # the links are javascript and must be clicked. Clicking a link will take you to the next page.
  jobListElems <- remDr$findElements('xpath',"//a[@title=\"View this role description\"]")
  length(jobListElems)
  
  # The job page has a link to the next job! If we start on job 1 then we can use those controls to go through all the jobs. 
  # and this saves us from pages!!!
  jobListElems[[1]]$clickElement()
  remDr$screenshot(display = TRUE)
      
  # The next job button is located at: //*[@id="requisitionDescriptionInterface.pagerDivID820.Next"]
  # If there is a next job aria-disabled="false" otherwise aria-disabled="true"
  nextIsDisabled <- FALSE
  remDr$screenshot(display = TRUE)
  write("Starting to collect jobs from Humana",file="log.txt",append = TRUE)
  while(nextIsDisabled == FALSE) {
    # Save the information
    jobDescElem <- remDr$findElement('xpath',"//*[@id=\"requisitionDescriptionInterface.ID3185.row.row1\"]/td[1]/div")
      jobDescRaw <- jobDescElem$getElementAttribute("outerHTML")[[1]]
      jobDescText <- htmlParse(jobDescRaw, asText = TRUE, encoding="UTF-8")
        jobName <- capture.output(xpathApply(jobDescText, "//span[@class=\"titlepage\"]")[[1]])
        jobName <- str_replace_all(jobName,"<[^>]+>","")
        jobName <- str_trim(jobName)
        jobName <- str_replace_all(jobName," ","_")
        jobID <- capture.output(xpathApply(jobDescText, "//*[@id=\"requisitionDescriptionInterface.reqContestNumberValue.row1\"]")[[1]])
        jobID <- str_replace_all(jobID,"<[^>]+>","")
        jobID <- str_trim(jobID)
        jobID <- str_replace_all(jobID," ","_")
        jobID <- paste(jobName,jobID,sep = "_")
    print(paste0("Writing job ",jobID))
    write(paste0("Writting job desc: ",jobID),file="log.txt",append = TRUE)
    saveXML(jobDescText,
            file = paste0(jobID,".xml"))
        # Get back with htmlParse("Job_Number_113110538.xml") 
    
    # Check to see if the next page is available and navigate there if it is
    nextStatus <- remDr$findElement('xpath',"//*[@id=\"requisitionDescriptionInterface.pagerDivID820.Next\"]")
    if(str_detect(nextStatus$getElementAttribute("aria-disabled")[[1]],"false")==TRUE) {
      nextLink <- remDr$findElement('xpath',"//*[@id=\"requisitionDescriptionInterface.pagerDivID820.Next\"]")
      Sys.sleep(round(runif(n=1,min=2,max=5),digits = 3))
      nextLink$clickElement()
      Sys.sleep(round(runif(n=1,min=2,max=7),digits = 3))
      remDr$screenshot(display = TRUE)
    } else {
      nextIsDisabled == TRUE
      write("No more jobs in list. Exiting.",file="log.txt",append = TRUE)
    }
  }  
  