library(RSelenium)
library(XML)
library(stringr)

# Set the working directory where 
# Project directory starts at something like: setwd("~/MSA/Fall 2017/Job_Desc_Text_Analytics")
setwd(paste0(getwd(),"/webscraping/Microsoft_job_scraping/files/"))

remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",port = 4445L)
remDr$open()

## Verify connection visually
remDr$navigate("https://careers.microsoft.com/search.aspx")
remDr$getCurrentUrl()
remDr$getTitle()
remDr$screenshot(display = TRUE)

## Search job by keyword
# The Humana jobs site requires us to use their form.
searchTerm <- "data"
searchCountries <- "US"
searchURL <- paste0("https://careers.microsoft.com/search.aspx#&&p2=all&p1=all&p3=all&p4=",searchCountries,"&p0=",searchTerm,"&p5=all")

# NOTE: Microsoft only lists up to 500 jobs. But if you keep clicking next it will keep going...
remDr$navigate(searchURL)
Sys.sleep(round(runif(n=1,min=4,max=7),digits = 3))
remDr$screenshot(display = TRUE)

## Find the first link in the list and click it to go to the first job
  jobListElem1 <- remDr$findElement('xpath',"//*[@id=\"tblSearchResults\"]/div[2]/div[2]/a")
  jobListElem1$clickElement()
  Sys.sleep(round(runif(n=1,min=4,max=7),digits = 3))
  remDr$screenshot(display = TRUE)
  
  
  # The next job button is located at: //*[@id="ContentPlaceHolder1_JobDetails2_hlNext"]
  # If there is a next job aria-disabled="false" otherwise aria-disabled="true"
  nextIsDisabled <- FALSE
  remDr$screenshot(display = TRUE)
  write("Starting to collect jobs from Microsoft",file="log.txt",append = TRUE)
  while(nextIsDisabled == FALSE) {
    
    # Save the information
    jobDescElem <- remDr$findElement('xpath',"//*[@id=\"ContentPlaceHolder1_JobDetails2_pnlJobDetails\"]")
     jobDescRaw <- jobDescElem$getElementAttribute("outerHTML")[[1]]
      jobDescText <- htmlParse(jobDescRaw, asText = TRUE, encoding="UTF-8")
        jobName <- capture.output(xpathApply(jobDescText, "//*[@id=\"ContentPlaceHolder1_JobDetails2_lblJobTitleText\"]")[[1]])
        jobName <- str_replace_all(jobName,"<[^>]+>","")
        jobName <- str_replace_all(jobName,"[^A-z]"," ") # Fix issues with special characters in names
        jobName <- str_replace_all(jobName,"\\W{2,}"," ") # Fix issues with multipe spaces
        jobName <- str_trim(jobName)
        jobName <- str_replace_all(jobName," ","_")
        jobID <- capture.output(xpathApply(jobDescText, "//*[@id=\"ContentPlaceHolder1_JobDetails2_lblJobCodeText\"]")[[1]])
        jobID <- str_replace_all(jobID,"<[^>]+>","")
        jobID <- str_trim(jobID)
        jobID <- str_replace_all(jobID," ","_")
        jobID <- paste(jobName,jobID,sep = "_")
      print(paste0("Writing job ",jobID))
      write(paste0("Writting job desc: ",jobID),file="log.txt",append = TRUE)
      saveXML(jobDescText,
            file = paste0(jobID,".xml"))
        # Get back with htmlParse("Job_Number_113110538.xml") 
      
    # Next button is located at //*[@id="ContentPlaceHolder1_JobDetails2_hlNext"]
    nextLink <- remDr$findElement('xpath',"//*[@id=\"ContentPlaceHolder1_JobDetails2_hlNext\"]")
    # nextLink$statusCodes
    # nextLink$status
    if(nextLink$status == 0) {
      Sys.sleep(round(runif(n=1,min=5,max=7),digits = 3))
      nextLink$clickElement()
      Sys.sleep(round(runif(n=1,min=5,max=8),digits = 3))
      remDr$screenshot(display = TRUE)
    } else {
      nextIsDisabled = TRUE
    }
      

  }
      
      