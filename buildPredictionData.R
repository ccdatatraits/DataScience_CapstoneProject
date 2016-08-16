library(tm)
library(RSQLite)
library(RWeka)
library(slam)
library(data.table)

#options(mc.cores=1)

# Input file (Sampled if prob is less than 1)
input_file <- function(filename, prob) {
  file_read <- file(filename, "r")
  full_file <- readLines(file_read, skipNul = TRUE)
  close(file_read)
  sample(full_file, length(full_file) * prob)
}

getCorpus <- function(v) {
  corpus <- VCorpus(VectorSource(v))
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, removeNumbers)
  corpus 
}

tdmToFreq <- function(tdm) {
  freq <- sort(row_sums(tdm, na.rm=TRUE), decreasing=TRUE)
  word <- names(freq)
  data.table(word=word, freq=freq)
}

processGram <- function(dt) {
  dt[, c("previous", "cur"):=list(unlist(strsplit(word, "[ ]+?[a-z]+$")), 
        unlist(strsplit(word, "^([a-z]+[ ])+"))[2]), by=word]
}

twitter <- input_file('final/en_US/en_US.twitter.txt', 0.01)
blogs <- input_file('final/en_US/en_US.blogs.txt', 0.01)
news <- input_file('final/en_US/en_US.news.txt', 0.01)

twitter_corp <- getCorpus(twitter)
blogs_corpus <- getCorpus(blogs)
news_corpus <- getCorpus(news)

concatenatedCorpuses <- c(twitter_corp, blogs_corpus, news_corpus)

PentagramWeka <- Weka_control(min = 5, max = 5)
PentagramTokenizer <- function(x) NGramTokenizer(x, PentagramWeka)
tdm_5 <- TermDocumentMatrix(concatenatedCorpuses, control = list(tokenize = PentagramTokenizer))

QuadgramWeka <- Weka_control(min = 4, max = 4)
QuadgramTokenizer <- function(x) NGramTokenizer(x, QuadgramWeka)
tdm_4 <- TermDocumentMatrix(concatenatedCorpuses, control = list(tokenize = QuadgramTokenizer))

TrigramWeka <- Weka_control(min = 3, max = 3)
TrigramTokenizer <- function(x) NGramTokenizer(x, TrigramWeka)
tdm_3 <- TermDocumentMatrix(concatenatedCorpuses, control = list(tokenize = TrigramTokenizer))

BigramWeka <- Weka_control(min = 2, max = 2)
BigramTokenizer <- function(x) NGramTokenizer(x, BigramWeka)
tdm_2 <- TermDocumentMatrix(concatenatedCorpuses, control = list(tokenize = BigramTokenizer))

db <- dbConnect(SQLite(), dbname="prediction.db")
dbSendQuery(conn=db, "CREATE TABLE NGramDB(word TEXT, previous TEXT, freq INTEGER, n INTEGER)")

freq_5 <- tdmToFreq(tdm_5)
processGram(freq_5)
sql_5 <- "INSERT INTO NGramDB VALUES ($cur, $previous, $freq, 5)"
dbBegin(db)
dbGetPreparedQuery(db, sql_5, bind.data = freq_5)
dbCommit(db)

freq_4 <- tdmToFreq(tdm_4)
processGram(freq_4)
sql_4 <- "INSERT INTO NGramDB VALUES ($cur, $previous, $freq, 4)"
dbBegin(db)
dbGetPreparedQuery(db, sql_4, bind.data = freq_4)
dbCommit(db)

freq_3 <- tdmToFreq(tdm_3)
processGram(freq_3)
sql_3 <- "INSERT INTO NGramDB VALUES ($cur, $previous, $freq, 3)"
dbBegin(db)
dbGetPreparedQuery(db, sql_3, bind.data = freq_3)
dbCommit(db)

freq_2 <- tdmToFreq(tdm_2)
processGram(freq_2)
sql_2 <- "INSERT INTO NGramDB VALUES ($cur, $previous, $freq, 2)"
dbBegin(db)
dbGetPreparedQuery(db, sql_2, bind.data = freq_2)
dbCommit(db)

dbDisconnect(db)