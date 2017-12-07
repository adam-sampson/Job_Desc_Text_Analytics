library(topicmodels)
library(RSQLite)
library(dplyr)
library(dbplyr)
library(tm)
library(stringr)
library(wordcloud)
library(ggplot2)
library(readr)

#---
# Load data from database
#---
# library(RSQLite)
  db.conn = dbConnect(SQLite(), dbname="JobsTextData.sqlite")
  jobs.df <- as.data.frame(tbl(db.conn,"jobCleanedText"))
  dbDisconnect(db.conn)
  rm(db.conn)
  str(jobs.df)

# Load resume
  resume.df <- read_file("./resume/Sampson_Resume_DA_2017.txt")
  resume.df <- iconv(resume.df,to = "UTF-8")
  resume.df <- str_replace_all(resume.df,"[\\r\\n\\t]"," ")
  resume.df <- data.frame(jobid = "SampsonResume", jobtitle = "none",jobdesc = resume.df,company = "resume")
  
  jobs.df <- rbind(jobs.df,resume.df)

#---
# Clean data even more
#---
  # Remove everything except for [a-zA-Z] [:space:] ' + - and replace with space
  jobs.df$jobdesc <- str_replace_all(jobs.df$jobdesc,"[^a-zA-Z[:space:]+\\-\']"," ")
  # Remove ' and replace with nothing.
  jobs.df$jobdesc <- str_replace_all(jobs.df$jobdesc,"\'","")
  # Convert to utf-8 explicitly
  jobs.df$jobdesc <- iconv(jobs.df$jobdesc, to = "utf-8")
#---
# Prepare data for use as corpus and tdm
#---
  jobs.corpus <- Corpus(DataframeSource(data.frame(doc_id = jobs.df$jobid,
                                                   text = jobs.df$jobdesc,
                                                   stringsAsFactors = FALSE)))
    # print(jobs.corpus)
    # inspect(jobs.corpus[1:5])
    # meta(jobs.corpus[[1]])
    # inspect(jobs.corpus[[1]])
    # lapply(jobs.corpus[[1]]$content[[2]],as.character)
  
  jobs.corpus <- tm_map(jobs.corpus,PlainTextDocument)
  jobs.corpus <- tm_map(jobs.corpus,content_transformer(tolower))
  jobs.corpus <- tm_map(jobs.corpus,removeWords,stopwords("english"))
    # remove the names of the company (I.E. apple or apple's) from the text 
  jobs.corpus <- tm_map(jobs.corpus,removeWords,tolower(c(unique(jobs.df$company),paste0(unique(jobs.df$company),"s"))))
  jobs.corpus <- tm_map(jobs.corpus,removeWords,c("ã‚â"))
  jobs.corpus <- tm_map(jobs.corpus,stripWhitespace)
    # print(jobs.corpus)
    # inspect(jobs.corpus[[1]])
    # lapply(jobs.corpus[[1]]$content[[2]],as.character)
  
  jobs.dtm <- DocumentTermMatrix(jobs.corpus)
    rownames(jobs.dtm) <- jobs.df$jobid
    rownames(jobs.dtm)
    
  freq <- colSums(as.matrix(jobs.dtm))
    length(freq)
    freq <- freq[order(freq,decreasing = TRUE)]
    # View(as.data.frame(freq))
    
#---
# Latent Dierichlet Analysis (LDA)
#---
    lda.control = list(
      # burnin = 4000,
      # iter = 2000,
      # thin = 500,
      seed = list(2003,5,63,100001,765),
      # nstart = 5,
      best = TRUE
    )
    
    k <- 5  
    
    #jobs.lda <- LDA(jobs.dtm,k,method = "Gibbs",control=lda.control)
    jobs.lda <- LDA(jobs.dtm,k)
      # Write out results
      jobs.lda.topics <- as.matrix(topics(jobs.lda))
      head(as.data.frame(jobs.lda.topics))
      # View(as.data.frame(jobs.lda.topics))
        length(as.data.frame(jobs.lda.topics)[,1])
      # Top 6 terms in each topic
        jobs.lda.terms <- as.matrix(terms(jobs.lda,6))
        head(as.data.frame(jobs.lda.terms))
      # Probabilities associeated with each topic assignment
        topicProbabilities <- as.matrix(jobs.lda@gamma)
          rownames(topicProbabilities) <- jobs.df$jobid
          View(as.data.frame(topicProbabilities,stringsAsFactors = FALSE))
      # Find relative importance of 2 topics
        topicProb <- function(x,t1,t2) {
          sort(topicProbabilities[x,])[k-(t1-1)]/sort(topicProbabilities[x,])[k-(t2-1)]
        }
        topic1ToTopic2 <- lapply(1:nrow(jobs.dtm),
                                 topicProb,t1=1,t2=2)
        topic2ToTopic3 <- lapply(1:nrow(jobs.dtm),
                                 topicProb,t1=2,t2=3)
      