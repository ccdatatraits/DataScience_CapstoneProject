# Task 1 - Data acquisition and cleaning
# 
# Tasks to accomplish
# Tokenization - identifying appropriate tokens such as words, punctuation, and numbers. Writing a function that takes a file as input and returns a tokenized version of it.
# Profanity filtering - removing profanity and other words you do not want to predict.
# 
# """ Remove quotation marks from an input string
# Args:
#   s (str): input string that might have the quote "" characters
# Returns:
#   str: a string without the quote characters
# """
removeQuotes <- function(s) {
  noquote(s) #TODO: Test
}

# """ Parse a line of the data file using the specified regular expression pattern
# Args:
#   datafileLine (str): input string that is a line from the data file
# Returns:
#   str: a string parsed using the given regular expression and without the quote characters
# """
parseDatafileLine <- function(datafileLine) {
  
}

# """ Parse a data file
# Args:
#   filename (str): input file name of the data file
# Returns:
#   RDD: a RDD of parsed lines #TODO: Remove all RDD
# """
NUMBER_OF_LINES <- 10L
ALL_LINES <- -1L
parseData <- function(filename, n = NUMBER_OF_LINES) {
  file <- file(filename, "r")
  linesRead <- readLines(file, n)
  close(file)
  linesRead
}

# """ Load a data file
# Args:
#   path (str): input file name of the data file
# Returns:
#   RDD: a RDD of parsed valid lines
# """
loadData <- function(path) {
  filename <- path
  raw <- parseData(filename)
  raw
}

# """ A simple implementation of input string tokenization
# Args:
#   string (str): input string
# Returns:
#   list: a list of tokens
# """
SPLIT_REGEX <- '\\W+'
simpleTokenize <- function(string) {
  unlist(strsplit(tolower(string), SPLIT_REGEX))
}

# """ An implementation of input string tokenization that excludes stopwords
# Args:
#   string (str): input string
# Returns:
#   list: a list of tokens without stopwords
# """
STOPWORDS_FILENAME <- 'stopwords.txt'
tokenize <- function(string) {
  stopwords_tokens <- parseData(STOPWORDS_FILENAME, ALL_LINES)
  setdiff(simpleTokenize(string), stopwords_tokens)
}

# 
# Questions to consider
# How should you handle punctuation?
# The data contains lots of times, dates, numbers and currency values. How to handle these? Are they useful for prediction?
# How do you find typos in the data?
# How do you identify garbage, or the wrong language?
# How do you define profanity? How do you ensure you don't remove words you want to include?
# How do you handle capital and lower cases?
# What is the best set of features you might use to predict the next word?