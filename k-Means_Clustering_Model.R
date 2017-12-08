library(tm)
library(ggplot2)
library(dplyr)
library(wordcloud)
library(cluster)
library(tm)
library(data.table)

source("sqLite.R")

jobs.df <- loadTextDfFromSqLite()

jobs.corpus <- Corpus(DataframeSource(jobs.df))

# Basic Cleaning the text for basic analysis
jobs.corpus <- tm_map(jobs.corpus,content_transformer(tolower))
jobs.corpus <- tm_map(jobs.corpus,removeWords,stopwords("english"))  
jobs.corpus <- tm_map(jobs.corpus,removePunctuation)  
jobs.corpus <- tm_map(jobs.corpus,stripWhitespace)  

# Document Term Matrix
#jobs.dtm <- DocumentTermMatrix(jobs.corpus)
jobs.tdm <- TermDocumentMatrix(jobs.corpus)

# Looking at frequent terms
freqterm <- findFreqTerms(jobs.tdm,lowfreq = 1700)
termFreq <- rowSums(as.matrix(jobs.tdm[freqterm,]))
termFreq <- data.table(term = names(termFreq), count = termFreq)
termFreq <- termFreq %>% arrange(desc(count))
termFreq$term <- factor(termFreq$term, levels = termFreq$term)

ggplot(termFreq,aes(x=term,y=count)) + 
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  ggtitle("Most common words in jobs dataset")

wordcloud(termFreq$term, termFreq$count)

# Clustering...
# Remove the really sparse terms
jobs.tdmat <- as.matrix(removeSparseTerms(jobs.tdm,sparse = 0.9))
length(jobs.tdmat[,1])  

distMatrix <- dist(scale(jobs.tdmat))
fit.hclust <- hclust(distMatrix, method="ward.D2")  
plot(fit.hclust)  

fit.kmeans <- kmeans(scale(jobs.tdmat),2)
fit.kmeans
# Let's try some other k-values for elbow method
k.max <- 30
wss <- sapply(1:k.max,
              function(k){kmeans(scale(jobs.tdmat),k)$tot.withinss})
wss
plot(1:k.max, wss,
     type="b",
     xlab = "Number of clusters K",
     ylab = "Total within-clusters sum of squares")    

fit.kmeans <- kmeans(scale(jobs.tdmat),13)
fit.kmeans  

fit.pam <- pam(daisy(jobs.tdmat,metric="euclidean"),3,diss=TRUE)
fit.pam
plot(fit.pam)  
