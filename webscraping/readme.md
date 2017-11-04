# Webscraping Methodology

## Installing RSelenium with Docker

Instructions were followed from: [https://cran.r-project.org/web/packages/RSelenium/vignettes/RSelenium-docker.html#why-docker](https://cran.r-project.org/web/packages/RSelenium/vignettes/RSelenium-docker.html#why-docker). However, note that there is extra information in these instructions which may be confusing to people who aren't power users.

Method used for Windows:

Get [Docker toolbox for Windows](https://docs.docker.com/toolbox/toolbox_install_windows/)

Install Docker Toolbox

Reboot the computer

Open Docker Quickstart Terminal

Note the IP address given when you start the Quickstart Terminal (for the future) usually 192.168.99.100

In the Docker Quickstart Terminal run the command 'docker pull selenium/standalone-firefox:2.53.0' 

## Using RSelenium in R

If you haven't already, open Docker Quickstart Terminal

Run the image using 'docker run -d -p 4445:4444 selenium/standalone-firefox:2.53.0'

In RStudio run the following code to make sure that the Docker RSelenium server is working
```
  library(RSelenium)
  remDr <- remoteDriver(remoteServerAddr = "192.168.99.100", port = 4445L)
  remDr$open()

  remDr$navigate("http://www.google.com/ncr")
  remDr$getTitle()
```
