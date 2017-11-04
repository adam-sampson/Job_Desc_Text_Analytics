library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",
                      +                       port = 4445L)
remDr$open()

remDr$navigate("http://www.google.com/ncr")
remDr$getTitle()