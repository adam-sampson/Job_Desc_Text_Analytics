

#### Creating Custom Dictionaries and loading each Dictionary into  a data frame 

education.df <- data.frame(
  id="Education",
  text =c("Bachelors", "Bachelor's","BA", "BS", "B.S.", "B.A.",
          "MS", "M.S.", "Masters",  "Master's", "PhD"), stringsAsFactors = FALSE)

tools.df <- data.frame(
  id="Tools",
  text=c("Java", "JavaScript", "C","C++", 
         "Objective-C", "Stata", "SAS", "Oracle",
         "Teradata",  "Vertica", "Python", "Scala",
         "Spark", "Hive", "Oozie", "Kafka", "R", "SQL",
         "NoSQL", "Cassandra",  "SQA", "Git", "Jenkins", 
         "Apache", "Hadoop", "AWS", "Azure", "HDFS", "Xcode Server",
         "POSIX", "NLP",  "Tomcat", "vLinux", "Matplotlib", 
         "Hive", "Pig", "HBase", "Hana", "Map Reduce", "J2EE", 
         "REST", "Unix",  "Perl", "Shell", "Impala", "Mongo", 
         "Bash", "Junit", "TestNG", "Cucumber", "Watir", "Appium", 
         "JMeter",  "SoapUI", "Racket", "numpy", "Pandas", "Druid",
         "Superset", "Tableau"), stringsAsFactors = FALSE)

education_relevantCourses.df <- data.frame(
  id="Courses",
  text=c("Statistics", "Machine learning", "data science", 
         "data analytics", "analytics",
         "Economics", "econometrics", 
         "STEM", "S.T.E.M.", "science", 
         "technology", "math","engineering",
         "data mining", "Computer Science",
         "Physics", "Computer Information Systems",
         "CIS", "C.I.S.","quantitative background", 
         "quantitative"), stringsAsFactors = FALSE)

skills.df <- data.frame(
  id="Skills", 
  text=c("MR Frameworks", "Multi threaded programming", 
         "Image classification", "ETL data pipelines",
         "ETL",  "data modeling", "modeling", "analysis",
         "tuning", "troubleshooting", "mining", "efficient",
         "efficiency", "engineer", "engineering", "problem solving", 
         "problem solver", "forcast", "forcasting",  "extraction", 
         "management", "report", "reporting", "manipulation", 
         "manipulate", "transform",  "exploratory", "explore",
         "query", "queries", "visualization", "segmentation", 
         "prototyping",  "prototype", "build", "building", "design",
         "designing", "debugging", "architect", "architecting",
         "optimization", "data pipelines", "pipelines","data mining",
         "machine learning", "dimensional data  models", "build",
         "building", "implementing", "implement", "manipulation",
         "cleansing", "recommend",  "natural language processing",
         "image analysis", "time series analysis", "regression", 
         "Scripting",  "script", "automation", "software engineering",
         "ROC", "R.O.C.", "relational database", "develop","driver",
         "support", "database management", "cross functional systems", 
         "optimization", "dimensional",  "decisions", "process",
         "opportunity", "opportunities", "development", "raw", 
         "unsupervised",  "supervised", "problem solving", "driven", 
         "decisions", "concept", "deployment", "production", "solution",
         "quality", "learns quickly", "learn", "vision", "long term", 
         "technical", "Deep learning",  "operations", "prototypes", 
         "algorithms", "unstructured", "structured", "warehouse", 
         "data warehouse",  "correlation", "statistics", "Bayesian", 
         "classifier"), stringsAsFactors = FALSE)

experience.df <- data.frame(
  id = "Experience",
  text=c("years of experience", 
         "programming", "data mining",
         "mining", "database", 
         "unstructured", "structured",
         "data science", "analysis",
         "modeling"),stringsAsFactors = FALSE)

softSkills.df <- data.frame(
  id="softskills",
  text=c("attention to detail", 
         "detail", "curious",
         "curiosity", "innovative",
         "time management", "team player",
         "collaborative", "interpersonal",
         "communication", "written", "oral",
         "critical thinking", "pro-active", 
         "pro active", "solution", "self-starter",
         "self starter","motivated"), stringsAsFactors = FALSE)

############

# Create master df with all dictionaries combined into one master custom dictionary
# max N = 105 obs - must be able to fit all into new df 

all.df <- rbind(tools.df, skills.df, education.df, education_relevantCourses.df,
                softSkills.df, experience.df, StringAsFactors = FALSE)
all.df

custom_dictionary.df <- data.frame(
  text=(all.df$text),
  stringsAsFactors = FALSE)
 

########################################################################


############

getReaders()

library(tm)
library(readr)

str(custom_dictionary.df)

custom_dictionary_list <- as.list(custom_dictionary.df)

Dictionary = data.frame(RecordContent = custom_dictionary.df,
                Type = all.df$id,
                stringsAsFactors = F)




# Create special reader function to retain each word in dictionary

myReader = data.frame(content=Dictionary$text,
    id=Dictionary$text)

str(myReader$content)

myReader$content <- as.list(myReader$content)

# Make my corpus. Read in the data using DataframeSource
# and the custom reader function where each dictionary word is a "document"

corpus <- as.VCorpus(myReader$content, reader = myReader)

str(corpus)
            # corpus is a List


#######################

library(quanteda)
library(tm)

#######################
View(Dictionary)

write.csv(Dictionary, file = "Custom Dictionary.csv", row.names = TRUE)
