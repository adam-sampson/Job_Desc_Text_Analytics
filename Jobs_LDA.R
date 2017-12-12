library(topicmodels)
library(RSQLite)
library(dplyr)
library(dbplyr)
library(tm)
library(stringr)
library(wordcloud)
library(ggplot2)
library(readr)
library(lsa)

#---
# Load data from database
#---
# library(RSQLite)
  db.conn = dbConnect(SQLite(), dbname="JobsTextData.sqlite")
  jobs.df <- as.data.frame(tbl(db.conn,"jobCleanedText"))
  dbDisconnect(db.conn)
  rm(db.conn)
  str(jobs.df)

# # Load resume
#   resume.df <- read_file("./resume/Sampson_Resume_DA_2017.txt")
#   resume.df <- iconv(resume.df,to = "UTF-8")
#   resume.df <- str_replace_all(resume.df,"[\\r\\n\\t]"," ")
#   resume.df <- data.frame(jobid = "SampsonResume", jobtitle = "none",jobdesc = resume.df,company = "resume")
  
  # jobs.df <- rbind(jobs.df,resume.df)

#---
# Clean data even more
#---
  cleanDataMore <- function(in.df) {
    # Remove everything except for [a-zA-Z] [:space:] ' + - and replace with space
    #in.df$jobdesc <- str_replace_all(in.df$jobdesc,"[^a-zA-Z[:space:]+\\-\']"," ")
    # Remove everything except for [a-zA-Z] [:space:] ' + and replace with space
    in.df$jobdesc <- str_replace_all(in.df$jobdesc,"[^a-zA-Z[:space:]+\']"," ")
    # Remove ' and replace with nothing.
    in.df$jobdesc <- str_replace_all(in.df$jobdesc,"\'","")
    # Convert to utf-8 explicitly
    in.df$jobdesc <- iconv(in.df$jobdesc, to = "utf-8")
    return(in.df)
  }
  
  jobs.df <- cleanDataMore(in.df = jobs.df)
  # resume.df <- cleanDataMore(jobs.df = resume.df)
  
#---
# Prepare data for use as corpus and tdm
#---
  convertToCleanCorpus <- function(in.df) {
    in.corpus <- Corpus(DataframeSource(data.frame(doc_id = in.df$jobid,
                                                     text = in.df$jobdesc,
                                                     stringsAsFactors = FALSE)))
      # print(in.corpus)
      # inspect(in.corpus[1:5])
      # meta(in.corpus[[1]])
      # inspect(in.corpus[[1]])
      # lapply(in.corpus[[1]]$content[[2]],as.character)
    
    in.corpus <- tm_map(in.corpus,PlainTextDocument)
    in.corpus <- tm_map(in.corpus,content_transformer(tolower))
    in.corpus <- tm_map(in.corpus,removeWords,stopwords("english"))
      # remove the names of the company (I.E. apple or apple's) from the text 
    in.corpus <- tm_map(in.corpus,removeWords,tolower(c(unique(in.df$company),paste0(unique(in.df$company),"s"))))
    in.corpus <- tm_map(in.corpus,removeWords,c("ã‚â"))
    in.corpus <- tm_map(in.corpus,stripWhitespace)
      # print(in.corpus)
      # inspect(in.corpus[[1]])
      # lapply(in.corpus[[1]]$content[[2]],as.character)
    return(in.corpus)
  }
  
  jobs.corpus <- convertToCleanCorpus(jobs.df)
    inspect(jobs.corpus)
  
  corpusToDTM <- function(in.corpus,in.df) {
    in.dtm <- DocumentTermMatrix(in.corpus)
      rownames(in.dtm) <- in.df$jobid
      rownames(in.dtm)
    return(in.dtm)
  }
  
  jobs.dtm <- corpusToDTM(jobs.corpus,jobs.df)
  
  freq <- colSums(as.matrix(jobs.dtm))
    length(freq)
    freq <- freq[order(freq,decreasing = TRUE)]
    # View(as.data.frame(freq))
  
  rowTotals <- apply(jobs.dtm , 1, sum) #Find the sum of words in each Document
  jobs.dtm   <- jobs.dtm[rowTotals> 0, ]           #remove all docs without words
  
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
    # jobs.k5.lda <- LDA(jobs.dtm,5)
    # jobs.k50.lda <- LDA(jobs.dtm,50)
    # saveRDS(jobs.k5.lda,file="jobs.k5.lda.RDS",compress = FALSE)
    # saveRDS(jobs.k50.lda,file="jobs.k50.lda.RDS",compress = FALSE)
    jobs.k5.lda <- readRDS('jobs.k5.lda.RDS')
    jobs.k50.lda <- readRDS('jobs.k50.lda.RDS')
    jobs.lda <- jobs.k5.lda
      # Write out results
      jobs.lda.topics <- as.matrix(topics(jobs.lda))
      head(as.data.frame(jobs.lda.topics))
      # View(as.data.frame(jobs.lda.topics))
        length(as.data.frame(jobs.lda.topics)[,1])
      # Top 10 terms in each topic
        jobs.lda.terms <- as.matrix(terms(jobs.lda,k=10))
        head(as.data.frame(jobs.lda.terms),n=10)
      # Probabilities associeated with each topic assignment
        topicProbabilities <- as.matrix(jobs.lda@gamma)
          # rownames(topicProbabilities) <- jobs.df$jobid
          rownames(topicProbabilities) <- jobs.lda@documents
          head(as.data.frame(topicProbabilities,stringsAsFactors = FALSE),n=10)
          # View(as.data.frame(topicProbabilities,stringsAsFactors = FALSE))
          # Each of these values is an estimated proportion of words from that 
          # document that are generated from that topic. For example, the model 
          # estimates that only about ??% of the words in document 1 were 
          # generated from topic 1.
      # Probabilities associated with each term for each topic
        termProbabilities.lda <- as.matrix(jobs.lda@beta)
          termProbabilities.lda <- t(termProbabilities.lda)
          rownames(termProbabilities.lda) <- jobs.lda@terms
          head(termProbabilities.lda)
          summary(termProbabilities.lda)
      # Find relative importance of 2 topics
        topicProb <- function(x,t1,t2) {
          sort(topicProbabilities[x,])[k-(t1-1)]/sort(topicProbabilities[x,])[k-(t2-1)]
        }
        topic1ToTopic2 <- lapply(1:nrow(jobs.dtm),
                                 topicProb,t1=1,t2=2)
        topic2ToTopic3 <- lapply(1:nrow(jobs.dtm),
                                 topicProb,t1=2,t2=3)
 
#---
# Comparing the LDA to new documents (resumes)
# https://stackoverflow.com/questions/16115102/predicting-lda-topics-for-new-data
#-
  resume.dir <- "./Resume"
  resume.df <- data.frame(jobid = character(),
                          jobtitle = character(),
                          jobdesc = character(),
                          company = character(),
                          stringsAsFactors = FALSE)
  for(file in list.files(path=resume.dir)) {
    resume.df <- rbind(resume.df,
                       data.frame(jobid = file,
                                  jobtitle = "none",
                                  jobdesc = read_file(paste0(resume.dir,"/",file)),
                                  company = "resume")
                       )
  }
  
  # Fix format error in resume 6
  resume.df <- resume.df[c(1:5,7),]
        
  # # Load resume
  # resume1.df <- read_file("./resume/Sampson_Resume_DA_2017.txt")
  # resume2.df <- read_file("./resume/Nathan_Thomas_Resume_20170201.txt")
  # resume3.df <- read_file("./resume/Resumetext_maxson.txt")
  # resume4.df <- read_file("./resume/Jack_Resume.txt")
  # resume5.df <- read_file("./resume/Resume_Sample_Art1.txt")
  # resume6.df <- read_file("./resume/Resume_Sample_Housekeeper1.txt")
  # resume7.df <- read_file("./resume/Resume_Sample_Sales.txt")
  # 
  # resume.df <- resume1.df
  # resume.df <- resume2.df
  # resume.df <- resume3.df
  
  resume.df$jobdesc <- iconv(resume.df$jobdesc,to = "UTF-8")
  resume.df$jobdesc <- str_replace_all(resume.df$jobdesc,"[\\r\\n\\t]"," ")
  # resume.df <- data.frame(jobid = "Resume", jobtitle = "none",jobdesc = resume.df,company = "resume",stringsAsFactors = FALSE)
        
  resume.df <- cleanDataMore(resume.df)
  
  # Convert resume to dtm
  resume.corpus <- convertToCleanCorpus(resume.df)
    inspect(resume.corpus)
  resume.dtm <- corpusToDTM(resume.corpus,resume.df)
  
  resume.dtm   <- resume.dtm[rowTotals> 0, ]           #remove all docs without words
        
  resume.topics <- topicmodels::posterior(jobs.lda,newdata = resume.dtm)
    # Probabilities associeated with each topic assignment
    topicProbabilities.resume <- as.matrix(resume.topics$topics)
      rownames(topicProbabilities.resume) <- resume.df$jobid
      colnames(topicProbabilities.resume) <- paste("Topic",colnames(topicProbabilities.resume))
      (as.data.frame(topicProbabilities.resume,stringsAsFactors = FALSE))
      write.csv(as.data.frame(topicProbabilities.resume,stringsAsFactors = FALSE),file = "resumeTopicProbabilities.csv")
      
    # Can we compare to termProbabilities instead?
    termProbabilities.resume <- t(as.matrix(resume.topics$terms))
      colnames(termProbabilities.resume) <- paste("Topic",colnames(termProbabilities.resume))
      head(termProbabilities.resume)
      write.csv(as.data.frame(termProbabilities.resume,stringsAsFactors = FALSE),file="ldaTermProbabilities.csv")
      # summary(termProbabilities.resume)
      
      head(termProbabilities.lda)    
      write.csv(as.data.frame(termProbabilities.lda,stringsAsFactors = FALSE),file="originalTermProbabilities.csv")
      
  # Need to get a distance measure...not an assignment.
  # Try cosine distance
  cosine(termProbabilities.lda[,1],termProbabilities.resume[,1])
  cosine(termProbabilities.lda[,2],termProbabilities.resume[,2])
  cosine(termProbabilities.lda[,3],termProbabilities.resume[,3])
  cosine(termProbabilities.lda[,4],termProbabilities.resume[,4])
  cosine(termProbabilities.lda[,5],termProbabilities.resume[,5])
  
  