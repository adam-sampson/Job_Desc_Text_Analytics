library(RSelenium)
library(XML)
library(stringr)

remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",
                      +                       port = 4445L)
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

  # Results are located under the following XPath
  # //*[@id="resultsDiv"]
  
  # Pagination (Next) is located under 
  # //*[@id="resultsDiv"]/ul/li[2]/a[2] or under a name "nextLink"
  # this next page link is only valid if class is "arrow_next enabled"
  
  # List of results are located under //*[@id="jobs_list"]
  # Each row is it's own element //*[@id="jobs_list"]/tbody/tr[1]
  # Each row that has jobs data has the class "searchresult"
  # The first column/td with class "title" and id format //*[@id="requisition-70818512"] contains the link
  # The link is inside a <p> tag
  # Each link to a job is in an <a> tag that has the XPath format of //*[@id="jobs_list-83877138"] where the number is a unique number
  
  # webElem <- remDr$findElement(using = 'id',value = "jobs_list")
  # webElem.children <- webElem$findChildElements(using = 'class', "searchresult")
  # webElem.children$value
  
  webElem <- remDr$findElement('xpath', value = "//*[@id=\"jobs_list\"]/tbody/tr[2]/td/p/a")
  webElem$clickElement()
  remDr$screenshot(display = TRUE) 
  
  jobDescElem <- remDr$findElement('xpath', "//*[@id=\"requisitionDescriptions\"]")
    jobDescRaw <- jobDescElem$getElementAttribute("outerHTML")[[1]]
    jobDescText <- htmlParse(jobDescRaw, asText = TRUE, encoding="UTF-8")
      jobID <- capture.output(xpathApply(jobDescText, "//li")[[1]])
      jobID <- str_replace_all(jobID,"<\\/?li>","")
      jobID <- str_replace_all(jobID,":","")
      jobID <- str_trim(jobID)
      jobID <- str_replace_all(jobID," ","_")
    setwd(paste0(getwd(),"/webscraping/Apple_job_scraping/files/"))
    saveXML(jobDescText,
            file = paste0(jobID,".xml"))
      # Get back with htmlParse("Job_Number_113110538.xml")
    
    
    