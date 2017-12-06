library(stringr)
library(RSQLite)
library(dplyr)
library(dbplyr)
library(text2vec)

#---
# Get data from database to explore
#---
  db.conn = dbConnect(SQLite(), dbname="JobsTextData.sqlite")
  
  plaintext.db <- tbl(db.conn,"jobPlainText")
  jobtext.df <- as.data.frame(select(plaintext.db,id,text))
  rm(plaintext.db)
  dbDisconnect(db.conn)
  rm(db.conn)

#---
# Create vocab list with text2vec
#---
  multiPrep <- function(x){
    out <- tolower(x) %>% 
      removePunctuation(preserve_intra_word_dashes = TRUE) %>%
      stripWhitespace()
  }
  
  # Use the regexp tokenizer to tokenize on spaces, tabs, and special characters (except -)
  regexTok <- function(x){
    out <- regexp_tokenizer(x," ")
  }
  
  prep_fun = tolower
  tok_fun = regexTok
  
  jobs.train <- itoken(jobtext.df$text,
                       preprocessor = prep_fun,
                       tokenizer = tok_fun,
                       ids = jobtext.df$id)  
  jobs.vocab <- create_vocabulary(jobs.train)
  
#---
# Identify n-grams
#---
  
