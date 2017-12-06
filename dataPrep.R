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
############################################################################
  specificCriterion <- c("Tools", "Skills", "Education", "Education_Courses", "Soft Skills", "Experience")
  
Tools <- c("Java", "JavaScript", "C","C++", "Objective-C", "Stata", "SAS", "Oracle", "Teradata",  "Vertica", "Python", "Scala", "Spark", "Hive", "Oozie", "Kafka", "R", "SQL", "NoSQL", "Cassandra",  "SQA", "Git", "Jenkins", "Apache", "Hadoop", "AWS", "Azure", "HDFS", "Xcode Server", "POSIX", "NLP",  "Tomcat", "vLinux", "Matplotlib", "Hive", "Pig", "HBase", "Hana", "Map Reduce", "J2EE", "REST", "Unix",  "Perl", "Shell", "Impala", "Mongo", "Bash", "Junit", "TestNG", "Cucumber", "Watir", "Appium", "JMeter",  "SoapUI", "Racket", "numpy", "Pandas", "Druid", "Superset", "Tableau")

Education <- c("Bachelors", "Bachelor's","BA", "BS", "B.S.", "B.A.", "MS", "M.S.", "Masters",  "Master's", "PhD")    

Education_Courses <- c("Statistics", "Machine learning", "data science", "data analytics",   "analytics", "Economics", "econometrics", "STEM", "S.T.E.M.", "science", "technology", "math",   "engineering","data mining", "Computer Science", "Physics", "Computer Information Systems",   "CIS", "C.I.S.","quantitative background", "quantitative")  

Skills <- c("MR Frameworks", "Multi threaded programming", "Image classification", "ETL data pipelines",  "ETL",  "data modeling", "modeling", "analysis", "tuning", "troubleshooting", "mining", "efficient",  "efficiency", "engineer", "engineering", "problem solving", "problem solver", "forcast", "forcasting",  "extraction", "management", "report", "reporting", "manipulation", "manipulate", "transform",  "exploratory", "explore", "query", "queries", "visualization", "segmentation", "prototyping",  "prototype", "build", "building", "design", "designing", "debugging", "architect", "architecting",  "optimization", "data pipelines", "pipelines","data mining", "machine learning", "dimensional data  models", "build", "building", "implementing", "implement", "manipulation", "cleansing", "recommend",  "natural language processing", "image analysis", "time series analysis", "regression", "Scripting",  "script", "automation", "software engineering", "ROC", "R.O.C.", "relational database", "develop",    "driver", "support", "database management", "cross functional systems", "optimization", "dimensional",  "decisions", "process", "opportunity", "opportunities", "development", "raw", "unsupervised",  "supervised", "problem solving", "driven", "decisions", "concept", "deployment", "production",  "solution", "quality", "learns quickly", "learn", "vision", "long term", "technical", "Deep learning",  "operations", "prototypes", "algorithms", "unstructured", "structured", "warehouse", "data warehouse",  "correlation", "statistics", "Bayesian", "classifier")   

Experience <- c("years of experience", "programming", "data mining", "mining", "database",  "unstructured", "structured", "data science", "analysis", "modeling")

SoftSkills <- C("attention to detail", "detail", "curious", "curiosity", "innovative", "time     management", "team player", "collaborative", "interpersonal", "communication", "written", "oral",    "critical thinking", "pro-active", "pro active", "solution", "self-starter", "self starter",     "motivated")
