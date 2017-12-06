library(maps)
library(stringr)

#---
# Create some dictionaries of special terms
#---
  # create a vector of US cities
  UScities <- str_replace(us.cities$name,"\\s..$","")

  # create a matrix of US states
  USstates <- data.frame(state = state.name, stateabb = state.abb)
  
  # create a list of common tools, processes, experience, education, etc
  specificCritereon <- c("R","SQL","Tableau")
  
