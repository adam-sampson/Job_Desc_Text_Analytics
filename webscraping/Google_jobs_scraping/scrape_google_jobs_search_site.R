library(RSelenium)

### Search Query
url_query <- "data science"
max_jobs_to_read <- 100

# Set the working directory where 
# Project directory starts at something like: setwd("~/MSA/Fall 2017/Job_Desc_Text_Analytics")
setwd(paste0(getwd(),"/webscraping/Google_jobs_scraping/files/"))

remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",port = 4445L)
remDr$open()

## Set google job search url (for jobs outside of google)
url_prefix <- "https://www.google.com/search?q="
url_query <- gsub(" ","+",url_query)
url_postfix <- "&ibp=htl;jobs#fpstate=tldetail&htichips=city:EdVbsxoLaYgy_XEgKLTT1A%3D%3D,city:-SE43rFRQIgXk8Dki377aQ%3D%3D,city:A2p5p_9Qa4h86rlA9p2O1g%3D%3D,city:PZDrEzLsZIig2umh0Lk_fQ%3D%3D,city:JeuczClEQojdT4yQQYPwhA%3D%3D,city:qULORiIWXIjFNPXE2pLqew%3D%3D,city:AxTdrtWAQIjkTA7ykuNApg%3D%3D,date_posted:month&htilrad=321.868&htischips=city;EdVbsxoLaYgy_XEgKLTT1A%3D%3D:Louisville_comma_%20KY;-SE43rFRQIgXk8Dki377aQ%3D%3D:Cincinnati_comma_%20OH;A2p5p_9Qa4h86rlA9p2O1g%3D%3D:Indianapolis_comma_%20IN;PZDrEzLsZIig2umh0Lk_fQ%3D%3D:Nashville_comma_%20TN;JeuczClEQojdT4yQQYPwhA%3D%3D:Lexington_comma_%20KY;qULORiIWXIjFNPXE2pLqew%3D%3D:Knoxville_comma_%20TN;AxTdrtWAQIjkTA7ykuNApg%3D%3D:Dayton_comma_%20OH,date_posted;month&htivrt=jobs"
url <- paste0(url_prefix,url_query,url_postfix)

## Verify connection visually
remDr$navigate(url)
remDr$getCurrentUrl()
remDr$getTitle()
Sys.sleep(3)
remDr$screenshot(display = TRUE)


## Now, load some pages of jobs to look at...
# Select the first list item with class="_yQk" and click it to activate that div.
# joblinkitem <- remDr$findElement('xpath',"//li[@class=\"_yQk\"]")
# joblinkitem$getElementAttribute("outerHTML")
# joblinkitem$clickElement()
# The first job should be clicked.
# remDr$screenshot(display = TRUE)

# Catch the first group of links to be able to load job description pages
joblinks <- remDr$findElements('xpath',"//li[@class=\"_yQk\"]")
# length(joblinks)
# joblinks[[20]]$clickElement()

counter <- 1
while((counter <= length(joblinks)) && (counter <= max_jobs_to_read)) {
  # Load the most recent list of jobs
  joblinks <- remDr$findElements('xpath',"//li[@class=\"_yQk\"]")
  # Click on the next one in the list
  joblinks[[counter]]$clickElement()
  uniquejobid <- joblinks[[counter]]$getElementAttribute("data-ved")
  
  Sys.sleep(runif(1,min=7,max=12)) # Sleep a random amount of time to let page load
  
  # Click the "read more" link
  # try(remDr$findElement('xpath',"//span[@class=\"_c2q\"]")$mouseMoveToLocation())
  try(remDr$findElement('xpath',"//*[@id=\"tl_ditc\"]/div/div/div[4]/div[2]/div/div/span[1]")$clickElement())
  
  jobdiv <- remDr$findElement('xpath',"//div[@class=\"_qSv\"]")
  write(jobdiv$getElementAttribute("outerHTML")[[1]], file = paste0(uniquejobid[[1]],".xml"))
  
  print(paste("Reviewed ",counter,"jobs of",max_jobs_to_read))
  counter <- counter + 1
}
