library(RSelenium)
library(XML)
library(stringr)

# Set the working directory where 
# Project directory starts at something like: setwd("~/MSA/Fall 2017/Job_Desc_Text_Analytics")
setwd(paste0(getwd(),"/webscraping/Apple_job_scraping/files/"))

remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",port = 4445L)
remDr$open()

## Test connection Visually
  remDr$navigate("https://jobs.apple.com/us/search?")
  remDr$getCurrentUrl()
  remDr$getTitle()
  
  ## NOTE: It may take a couple of seconds for all elements of a page to load!
  remDr$screenshot(display = TRUE) 

## Search job by keyword
  # The Apple jobs site allows us to search using URL. This makes things easier in code
  searchTerm <- "data"
  searchPage <- "0"
  searchCorporateOnly <- "1" # 1 = TRUE
  searchURL <- paste0("https://jobs.apple.com/us/search?#&ss=",searchTerm,"&t=",searchCorporateOnly,"&so=&lo=0*USA&pN=",searchPage)
  remDr$navigate(searchURL)
  remDr$screenshot(display = TRUE) 

saveJobsFromPage <- function() {
  ## Get the number of elements in the jobs list on a page
  ## On the Apple Jobs site the xpath to only find links to jobs is: "//*[@id=\"jobs_list\"]/tbody/tr/td/p/a"
  jobListElem <- remDr$findElements('xpath',"//*[@id=\"jobs_list\"]/tbody/tr/td/p/a")
  
  ## Cycle through each link on the page using a random delay between clicking links. Save results to a file
  for(jobLink in jobListElem) {
    jobLink$clickElement()
    remDr$screenshot(display = TRUE)
      jobDescElem <- remDr$findElement('xpath', "//div[@class=\"requisition\" and not(contains(@style,'display: none'))]//div[@id=\"job\"]")
        jobDescRaw <- jobDescElem$getElementAttribute("outerHTML")[[1]]
        jobDescText <- htmlParse(jobDescRaw, asText = TRUE, encoding="UTF-8")
          jobID <- capture.output(xpathApply(jobDescText, "//li")[[1]])
          jobID <- str_replace_all(jobID,"<\\/?li>","")
          jobID <- str_replace_all(jobID,":","")
          jobID <- str_trim(jobID)
          jobID <- str_replace_all(jobID," ","_")
        print(paste0("Writing job ",jobID))
        write(paste0("Writting job desc: ",jobID),file="log.txt",append = TRUE)
        saveXML(jobDescText,
                file = paste0(jobID,".xml"))
          # Get back with htmlParse("Job_Number_113110538.xml")
    Sys.sleep(round(runif(n=1,min=5,max=15),digits = 3))
  }
} 
  
  # In order to gind the next page arrow, and see if it is enabled or disabled
  # nextLink <- remDr$findElement('xpath', "//a[@name=\"nextLink\"]")
  # str_detect(nextLink$getElementAttribute("class")[[1]],"enabled")
  # str_detect(nextLink$getElementAttribute("class")[[1]],"disabled")
  
## Save the jobs from page 1, then loop through every page saving the jobs on that page
  nextIsDisabled <- FALSE
  pageID <- 0
  write("Starting to collect jobs from Apple",file="log.txt",append = TRUE)
  
  # In case there is only one page first we should get all the items on the first page
  print(paste0("Getting values from page: 0"))
  write(paste0("Getting values from page: 0"),file="log.txt",append = TRUE)
  saveJobsFromPage()
  
  while(nextIsDisabled == FALSE) {
    nextLink <- remDr$findElement('xpath', "//a[@name=\"nextLink\"]")
    if(str_detect(nextLink$getElementAttribute("class")[[1]],"enabled")==TRUE) {
      nextLink$clickElement()
      pageID <- pageID + 1
      remDr$screenshot(display = TRUE)
      # Wait a random amount of time before switching pages
      Sys.sleep(round(runif(n=1,min=5,max=15),digits = 3))
      
      print(paste0("Getting values from page: ",pageID))
      write(paste0("Getting values from page: ",pageID),file="log.txt",append = TRUE)
      # After we've switched to a new page and delayed randomly it is time to get all the jobs on the page
      saveJobsFromPage()
      
    } else {
      nextIsDisabled = TRUE
      print("No more pages detected")
    }
    
  }
  