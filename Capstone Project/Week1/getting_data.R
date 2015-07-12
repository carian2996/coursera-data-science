# Ian Castillo Rosales
# Getting data and overview
# 07/06/2015

# OPTIONAL: Install framework package for text mining applications within R
# install.packages("tm")

# Load tm package. Loading required NLP package
library(NLP)
library(tm)
source("~/Coursera/count_nrows.R")

# Set a local working directory (depends of you)
setwd("~/Coursera/data/en_US/")

# Create a rute for your Corpus
dirCorpus <-  DirSource("~/Coursera/data/en_US/")
corpus <- Corpus(dirCorpus, readerControl = list(language = "en"))

# Summary what went in
summary(corpus)

# ===== Load a sample of the corpus =====

# Create a connection and read certains lines of the corpus

sample_creation <- function(sample_size, path){
    
}

sample_size <- 1000
path <- "en_US.twitter.txt"

con <- file(path)
nrow_text <- numrow_windows("en_US.twitter.txt")

readLines(con, nrow_text)
?scan

