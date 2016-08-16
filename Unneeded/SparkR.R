install.packages("rJava")
library(rJava)

# Get your spark path (Prereq: brew install hadoop apache-spark)
spark_path <- strsplit(system("brew info apache-spark",intern=T)[4],' ')[[1]][1]
# Navigate to SparkR folder
.libPaths(c(file.path(spark_path,"libexec", "R", "lib"), .libPaths()))
# Load the library
library(SparkR)

Sys.setenv(SPARK_MEM="4g")
sc <- sparkR.init(master="local[*]") # creating a SparkContext
sqlContext <- sparkRSQL.init(sc)

#data <- textFile(sc, "final/en_US/en_US.twitter.txt")
data <- read.delim("final/en_US/en_US.twitter.txt", header = FALSE, skipNul = TRUE)
en_US_twitter_DF <- createDataFrame(sqlContext, data)