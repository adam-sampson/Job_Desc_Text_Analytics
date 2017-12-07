library(RSQLite)
library(dplyr)
library(dbplyr)
library(tm)
library(lsa)
library(stringr)
library(wordcloud)
library(SnowballC)
library(ggplot2)
library(readr)

#---
# Load data from database
#---
  # library(RSQLite)
  db.conn = dbConnect(SQLite(), dbname="JobsTextData.sqlite")
  jobs.df <- as.data.frame(tbl(db.conn,"jobCleanedText"))
  # rm(db.conn)
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
  jobs.corpus <- tm_map(jobs.corpus,stripWhitespace)
    # print(jobs.corpus)
    # inspect(jobs.corpus[[1]])
    # lapply(jobs.corpus[[1]]$content[[2]],as.character)
  
  jobs.tdm <- TermDocumentMatrix(jobs.corpus)
    print(jobs.tdm)
    findFreqTerms(jobs.tdm,lowfreq = 2000)
    termcount <- apply(jobs.tdm,1,sum)
      head(termcount[order(termcount,decreasing = T)],20)
    wordcloud(names(termcount),termcount,min.freq = 2000,random.order = FALSE)
      rm(termcount)

#---
# Find ngrams https://rpubs.com/brianzive/textmining
#---
  # BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
  BigramTokenizer <- function(x) ngrams(x,n=2)
  jobs.bg.tdm <- TermDocumentMatrix(jobs.corpus, control = list(tokenize = BigramTokenizer))
    print(jobs.bg.tdm)
    # findFreqTerms(jobs.bg.tdm)[1:5]
    # inspect(jobs.bg.tdm)

#---
# Distance with raw tdm
#---
  jobs.td.mat <- as.matrix(jobs.tdm)
    length(colnames(jobs.td.mat))
    length(jobs.df$jobid)
    colnames(jobs.td.mat) <- jobs.df$jobid
  jobs.td.mat <- as.textmatrix(as.matrix(jobs.tdm))
  # dist.jobs.td <- dist(t(as.matrix(jobs.td.mat)))
    
#---
# Calculate Latent Semantic Analysis (on term document matrix (tdm))
#---
  jobs.mat <- as.matrix(jobs.tdm)
    length(colnames(jobs.mat))
    length(jobs.df$jobid)
    colnames(jobs.mat) <- jobs.df$jobid
  jobs.mat.lsa <- lw_bintf(jobs.mat) * gw_idf(jobs.mat) # weighting
  lsa_model <- lsa(jobs.mat.lsa)  
    dim(lsa_model$tk) #Terms x New LSA Space
    dim(lsa_model$dk) #Documents x New LSA Space
    length(lsa_model$sk) #Singular Values
    # lsa_model
  lsa.text.mat <- as.textmatrix(lsa_model)
    lsa.text.mat
    print(lsa.text.mat)
  # dist.jobs.lsa <- dist(t(lsa.text.mat))
  #   dist.jobs.lsa  
    
  # compare two terms with the cosine measure
  cosine(lsa.text.mat["coding",], lsa.text.mat["insurers",])
  #compare two documents with pearson
  cor(lsa.text.mat[,1],lsa.text.mat[,1],method="pearson")
  
  #get cosine distance between terms
  cosine(lsa.text.mat[1,],lsa.text.mat[2,])
  #get cosine distance between documents
  cosine(lsa.text.mat[,1],lsa.text.mat[,1895])
  # get cosine for all documents in a matrix
  cos.lsa <- cosine(lsa.text.mat)
  
  associate(lsa.text.mat,"r", measure = "cosine", threshold = 0.7)
  
  # create a function to take the LSA and then compare one of the documents in it to all of the other documents and return a vector
  cosDistAllJobs <- function(in.mat,col.of.resume) {
    out.cos <- NULL
    for(i in 1:length(in.mat[1,])) {
      out.cos = c(out.cos,cosine(in.mat[,i],in.mat[,col.of.resume]))
    }
    return(out.cos)
  }

  resume1.cos <- cosDistAllJobs(lsa.text.mat,1895)
    resume1.cos <- data.frame(id = jobs.df$jobid, cosine = resume1.cos,stringsAsFactors = FALSE)
    resume1.cos <- resume1.cos %>% arrange(desc(cosine))
    
#---
# Perform Multi-dimensional Scaling (MDS)
#---
  # plot_mds <- function(dist.mat.in) {
  #   fit <- cmdscale(dist.mat.in, eig=TRUE, k=2)
  #   points <- data.frame(x=fit$points[, 1], y=fit$points[, 2])
  #   ggplot(points,aes(x=x, y=y)) + 
  #     geom_point(data=points,aes(x=x, y=y, color=df$view)) + 
  #     geom_text(data=points,aes(x=x, y=y-0.2, label=row.names(df)))
  # }
  # 
  # plot_mds(dist.jobs.lsa)  
  