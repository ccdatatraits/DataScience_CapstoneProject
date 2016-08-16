# Task 0 - Understanding the problem
# 
# Tasks to accomplish
# Obtaining the data - Can you download the data and load/manipulate it in R?
# Familiarizing yourself with NLP and text mining - Learn about the basics of natural language processing and how it relates to the data science process you have learned in the Data Science Specialization.
# 
# Check that the zipfile exists or not
zipfile <- "Coursera-SwiftKey.zip"
# If zipfile doesn't exist, fetch the data from the URL
if (!file.exists(zipfile)) {
  sprintf("Fetching Data: %s", zipfile)
  zipfile_url <- paste("https://d396qusza40orc.cloudfront.net/", 
                       "dsscapstone/dataset/Coursera-SwiftKey.zip", sep = "")
  download.file(zipfile_url, zipfile, method = "curl")
  dateDownloaded <- date()
  dateDownloaded
} else sprintf("Data: %s already exist", zipfile)

# Check that zip file has been unzipped by looking for en_US.blogs.txt
blogsEN_US <- "final/en_US/en_US.blogs.txt"
newsEN_US <- "final/en_US/en_US.news.txt"
twitterEN_US <- "final/en_US/en_US.twitter.txt"
# If file doesn't exist, then unzip data
if (!file.exists(blogsEN_US)) {
  print("Unzipping Data")
  unzip(zipfile)
} else sprintf("Data: %s already unzipped", blogsEN_US)
## Read unzipped data into R objects
file_blogsEN_US <- file(blogsEN_US, "r")
readLines(file_blogsEN_US, 10)
close(file_blogsEN_US)
# 
# Questions to consider
# What do the data look like?
# Where do the data come from?
# Can you think of any other data sources that might help you in this project?
# What are the common steps in natural language processing?
# What are some common issues in the analysis of text data?
# What is the relationship between NLP and the concepts you have learned in the Specialization?