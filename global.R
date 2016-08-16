library(stringr)
library(RSQLite)
library(tm)

normalise <- function(inputText) {
  unlist(strsplit(removeNumbers(removePunctuation(tolower(stripWhitespace(str_trim(inputText))))), split = ' '))
}

ngram <- function(inputText, db) {
  sentence <- normalise(inputText)
  
  for (i in 4:1) {
    gram <- paste(tail(sentence, i), collapse=" ")
    sql <- paste0("SELECT word, freq FROM NGramDB WHERE previous=='", paste(gram), "' AND n==", 
                  i + 1, " LIMIT 3")
    res <- dbSendQuery(conn=db, sql)
    predicted <- dbFetch(res, n=-1)
    
    if (nrow(predicted) > 0) return(predicted)
  }
  "{COULDN'T PREDICT}"
}

predict <- function(inputText) {
  if (is.null(inputText) || "" == inputText) predicted <- ""
  else {
    db <- dbConnect(SQLite(), dbname="prediction.db")
    predicted <- ngram(inputText, db)
    dbDisconnect(db)
  }
  predicted
}